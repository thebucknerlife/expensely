module Expensely
  class App
    def self.start_teams
      Organization.all.each do |org|
        token = org.slack_token_json['bot']['bot_access_token']
        bot = SlackRubyBot::Server.new(token: token)
        bot.start_async
      end
    end
  end
end
