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
          "\n",
          "* hi -> create a new reimbursement request or return your existing request url",
          "* review -> list your existing reimbursement requests",
          "\n",
          "Still have questions? Write us at expensely@thirtytoship.io or visit us at #expenselyfeedback"
        ].join("\n")
      end
    end
  end
end
