require "#{Rails.root}/bots/expensely"

class AuthController < ApplicationController

  def slack
    response = SlackAuth.request_token(params[:code])

    team = Team.find_or_initialize_by(team_id: response['team_id'])
    new_team = team.new_record?

    team.update(
      oauth_response: response,
      team_name: response['team_name'],
      access_token: response['access_token'],
      bot_access_token: response['bot']['bot_access_token'],
    )
    start_bot(team) if new_team

    redirect_to :success
  rescue Slack::Web::Api::Error => e
    logger.info("Slack Auth Failed - #{e}")
    redirect_to :failed
  end

  def start_bot(team)
    Thread.new do
      bot = SlackRubyBot::Server.new(token: team.bot_access_token)
      bot.start_async
    end
  end
end
