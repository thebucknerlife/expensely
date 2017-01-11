class Eddard < SlackRubyBot::Bot
  command 'new' do |client, data, match|
    client.say(channel: data.channel, text: "Let's get started!")
  end
end
