module Expensely
  class Bot < SlackRubyBot::Bot
    CHARM = %w( Huzzah! Yas! Wootwoot! )

    command 'cool' do |client, data, match|
      client.say(channel: data.channel, text: 'nice!')
    end

    match /.*/ do |client, data, match|
      user = User.find_or_initialize_by(slack_id: data.user)
      set_attrs_from_slack(user) if user.new_record?

      if user.requests.in_progress.any?
        request = user.requests.in_progress.first
      else
        request = user.requests.create
      end

      client.say(channel: data.channel, text: new_response(request))
    end

    class << self
      def new_response(request)
        "#{CHARM.sample} Receipts! My faaavorite. Let's get them uploaded here #{new_request_url(request)}"
      end

      def new_request_url(request)
        Rails.application.routes.url_helpers.request_url(id: request.id, host: ENV['HOST'])
      end

      def set_attrs_from_slack(user)
        response = client.users_info(user: user.slack_id)
        attrs = { 'slack_name' => response.user.name }
        attrs.merge(response.user.profile.to_h.slice('email', 'first_name', 'last_name'))
        user.update(attrs)
      end

      def client
        @client ||= Slack::Web::Client.new
      end
    end
  end
end
