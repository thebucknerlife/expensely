module Expensely
  class App
    def self.start_teams
      Team.all.each do |team|
        log "Starting bot for team ##{team.id}, #{team.team_name}..."
        bot = SlackRubyBot::Server.new(token: team.bot_access_token)
        bot.start_async
        log "...done."
      end
      log "Finished starting all bots!"
    end

    def self.log(msg)
      Rails.logger.info(msg)
    end
  end
end
