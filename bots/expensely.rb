class Expensely < SlackRubyBot::Bot
  CHARM = %w( Huzzah! Yas! Doit! )
  command 'new' do |client, data, match|
    user = User.find_or_create_by(slack_id: data.user)
    request = Request.create(user: user)
    client.say(channel: data.channel, text: "Let's get started! #{CHARM.sample} #{Rails.application.routes.url_helpers.edit_request_url(id: request.id, host: ENV['HOST'])}")
  end
end
