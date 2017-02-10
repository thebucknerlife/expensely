module Expensely
  module Utils
    module User
      include Expensely::Utils::WebClient

      def find_or_create_user_from(data)
        Rails.logger.info("~~ Find or Create using data #{ap data}~~")

        user = ::User.find_or_initialize_by(slack_id: data.user)
        user.new = user.new_record?
        set_attrs_from_slack(user, data) if user.new?

        user
      end

      def set_attrs_from_slack(user, data)
        team = Team.find_by(team_id: team_id(data))
        user.team = team
        response = web_client(team).users_info(user: user.slack_id)
        attrs = { 'slack_name' => response.user.name }
        attrs.merge!(response.user.profile.to_h.slice('email', 'first_name', 'last_name'))
        user.update(attrs)
      end

      def team_id(data)
        data.team || data.source_team
      end
    end
  end
end
