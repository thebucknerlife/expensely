module Expensely
  module Utils
    class BotClient
      def self.tell_user(user, text)
        dm_channel = "@#{user.slack_name}"
        team = user.team

        client_for(team).chat_postMessage(channel: dm_channel, text: text, as_user: true)
      end

      def self.client_for(team)
        Slack::Web::Client.new(token: team.bot_access_token)
      end
    end
  end
end
