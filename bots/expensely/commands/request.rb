module Expensely
  module Commands
    class Request < SlackRubyBot::Commands::Base
      extend Expensely::Utils::User

      match /.*/

      def self.call(client, data, match)
        user = find_or_create_user_from data

        if user.requests.in_progress.any?
          request = user.requests.in_progress.first
        else
          request = user.requests.create
        end

        client.say(
          channel: data.channel,
          text: user.new? ? first_response(request, user) : new_response(request)
        )
      end

      def self.first_response(request, user)
        "hey hey hey, its time to balance the books #{user.first_name}! let's get you reimbursed #{request.new_request_url}"
      end

      def self.new_response(request)
        "Receipts! My faaavorite. Let's get them uploaded here #{request.new_request_url}"
      end
    end
  end
end
