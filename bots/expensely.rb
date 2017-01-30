class Expensely < SlackRubyBot::Bot
  CHARM = %w( Huzzah! Yas! Wootwoot! )

  command 'cool' do |client, data, match|
    client.say(channel: data.channel, text: 'nice!')
  end

  match /.*/ do |client, data, match|
    user = User.find_or_create_by(slack_id: data.user)
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
  end
end
