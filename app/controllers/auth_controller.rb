class AuthController < ApplicationController

  def slack
    response = SlackAuth.request_token(params[:code])

    org = Organiztion.find_or_create_by(team_id: response['team_id'])
    org.update(slack_token_json: response, team_name: response['team_name'])

    redirect_to :success
  rescue Slack::Web::Api::Error
    redirect_to :failed
  end

  def success
  end

  def failed
  end
end
