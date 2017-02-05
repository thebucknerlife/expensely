module Expensely
  class Bot < SlackRubyBot::Bot
    CHARM = %w( Huzzah! Yas! Wootwoot! )

    #command 'cool' do |client, data, match|
      #client.say(channel: data.channel, text: 'nice!')
    #end

    match /.*/ do |client, data, match|
      team_id = data.team
      user = User.find_or_initialize_by(slack_id: data.user)
      set_attrs_from_slack(user, team_id) if user.new_record?

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

      def set_attrs_from_slack(user, team_id)
        byebug
        team = Team.find_by(team_id: team_id)
        response = client(team).users_info(user: user.slack_id)
        attrs = { 'slack_name' => response.user.name }
        attrs.merge!(response.user.profile.to_h.slice('email', 'first_name', 'last_name'))
        user.update(attrs)
      end

      def client(team)
        Slack::Web::Client.new(token: team.access_token)
      end
    end
  end
end
