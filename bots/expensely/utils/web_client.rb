module Expensely
  module Utils
    module WebClient
      def web_client(team)
        token = team.access_token
        Slack::Web::Client.new(token: token)
      end
    end
  end
end
