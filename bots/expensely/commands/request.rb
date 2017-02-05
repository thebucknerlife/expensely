module Expensely
  module Commands
    class Request < SlackRubyBot::Commands::Base
      CHARM = %w( Huzzah! Yas! Wootwoot! )

      match /.*/ do |client, data, match|
        team_id = data.team
        user = User.find_or_initialize_by(slack_id: data.user)
        new_user = user.new_record?
        set_attrs_from_slack(user, team_id) if new_user

        if user.requests.in_progress.any?
          request = user.requests.in_progress.first
        else
          request = user.requests.create
        end

        client.say(
          channel: data.channel,
          text: new_user ? first_response(request, user) : new_response(request)
        )
      end

      class << self
        def first_response(request, user)
          "hey hey hey, its time to balance the books #{user.first_name}! let's get you reimbursed #{new_request_url(request)}"
        end

        def new_response(request)
          "#{CHARM.sample} Receipts! My faaavorite. Let's get them uploaded here #{new_request_url(request)}"
        end

        def new_request_url(request)
          Rails.application.routes.url_helpers.request_url(id: request.id, host: ENV['HOST'])
        end

        def set_attrs_from_slack(user, team_id)
          team = Team.find_by(team_id: team_id)
          response = web_client(team).users_info(user: user.slack_id)
          attrs = { 'slack_name' => response.user.name }
          attrs.merge!(response.user.profile.to_h.slice('email', 'first_name', 'last_name'))
          user.update(attrs)
        end

        def web_client(team)
          Slack::Web::Client.new(token: team.access_token)
        end
      end
    end
  end
end
