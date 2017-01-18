class Expensely < SlackRubyBot::Bot
  CHARM = %w( Huzzah! Yas! Wootwoot! )

  command 'new' do |client, data, match|
    user = User.find_or_create_by(slack_id: data.user)
    request = Request.create(user: user)
    client.say(channel: data.channel, text: new_response(request))
  end

  class << self
    def new_response(request)
      "#{CHARM.sample} Receipts! My faaavorite. Let's get them uploaded here #{new_request_url(request)}"
    end

    def new_request_url(request)
      Rails.application.routes.url_helpers.edit_request_url(id: request.id, host: ENV['HOST'])
    end
  end
end
