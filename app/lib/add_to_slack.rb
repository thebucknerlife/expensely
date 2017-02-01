class AddToSlack
  class << self
    def auth_url
      [base_url,'?',params.to_query].join
    end

    def params
      {
        scope: 'incoming-webhook,bot,users.profile:read',
        client_id: ENV['SLACK_APP_CLIENT_ID'],
        redirect_uri: 'http://localhost:3000/auth/slack',
      }
    end

    def base_url
      "https://slack.com/oauth/authorize"
    end
  end
end
