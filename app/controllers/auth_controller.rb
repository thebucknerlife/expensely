class AuthController < ApplicationController

  def slack
    response = SlackAuth.request_token(params[:code])

    org = Organization.find_or_initialize_by(team_id: response['team_id'])
    new_org = org.new_record?
    org.update(slack_token_json: response, team_name: response['team_name'])
    start_bot(org) if new_org

    redirect_to :success
  rescue Slack::Web::Api::Error
    redirect_to :failed
  end

  def success
  end

  def failed
  end

  def start_bot(org)
    Thread.new do
      token = org.slack_token_json['bot']['bot_access_token']
      bot = SlackRubyBot::Server.new(token: token)
      bot.start_async
    end
  end
end
