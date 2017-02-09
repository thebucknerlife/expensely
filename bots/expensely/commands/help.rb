module Expensely
  module Commands
    class Help < SlackRubyBot::Commands::Base
      command 'help'

      def self.call(client, data, match)
        client.say(channel: data.channel, text: help_text)
      end

      def self.help_text
        [
          "Hey! Here are the things I can do!",
          "* new -> create a new reimbursement request or return your existing request url",
          "* review -> list your existing reimbursement requests"
        ].join("\n")
      end
    end
  end
end
