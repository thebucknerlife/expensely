module Expensely
  module Commands
    class Review < SlackRubyBot::Commands::Base
      command 'review'

      def self.call(client, data, match)
        client.say(channel: data.channel, text: 'nice!')
      end

      def user

      end
    end
  end
end
