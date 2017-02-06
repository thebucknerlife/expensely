class SlackAuth
  class << self
    def request_token(code)
      client.oauth_access(auth_params(code))
    end

    def auth_params(code)
      {
        client_id: ENV['SLACK_APP_CLIENT_ID'],
        client_secret: ENV['SLACK_APP_CLIENT_SECRET'],
        code: code,
        redirect_uri: "http://#{ENV['HOST']}/auth/slack",
      }
    end

    def client
      # client is using wrong token
      @client ||= Slack::Web::Client.new
    end
  end
end
