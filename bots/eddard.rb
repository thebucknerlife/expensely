class Eddard < SlackRubyBot::Bot
  CHARM = %w( Huzzah! Yas! Doit! )
  command 'new' do |client, data, match|
    client.say(channel: data.channel, text: "Let's get started! #{CHARM.sample}")
  end
end
