class Cool < SlackRubyBot::Commands::Base
  command 'chill'

  def self.call(client, data, match)
    client.say(channel: data.channel, text: 'nice!')
  end
end
