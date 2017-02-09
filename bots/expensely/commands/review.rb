module Expensely
  module Commands
    class Review < SlackRubyBot::Commands::Base
      extend Expensely::Utils::User

      command 'review'

      def self.call(client, data, match)
        user = find_or_create_user_from data

        requests = {
          in_progress: user.requests.in_progress,
          submitted: user.requests.submitted,
          approved: user.requests.approved,
        }

        text = Expensely::Decorators::RequestsDecorator.review(requests)

        client.say(text: text, channel: data.channel)
      end
    end
  end
end
