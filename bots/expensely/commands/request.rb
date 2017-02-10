module Expensely
  module Commands
    class Request < SlackRubyBot::Commands::Base
      extend Expensely::Utils::User

      command 'new'
      command 'hi'

      def self.call(client, data, match)
        user = find_or_create_user_from data

        request = if user.requests.in_progress.any?
          user.requests.in_progress.order(:created_at).first
        else
          user.requests.create
        end

        client.say(text: text(request, user), channel: data.channel)
      end

      def self.text(request, user)
        url = request.new_request_url
        if user.new?
          "hey hey hey, its time to balance the books #{user.first_name}! let's get you reimbursed #{url}"
        else
          "Receipts! My faaavorite. Let's get them uploaded here #{url}"
        end
      end
    end
  end
end
