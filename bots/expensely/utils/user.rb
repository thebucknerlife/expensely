module Expensely
  module Utils
    module User
      include Expensely::Utils::WebClient

      def find_or_create_user_from(data)
        user = ::User.find_or_initialize_by(slack_id: data.user)
        user.newly_created = user.new_record?
        set_attrs_from_slack(user, data.team) if user.newly_created

        user
      end

      def set_attrs_from_slack(user, team_id)
        team = Team.find_by(team_id: team_id)
        response = web_client(team).users_info(user: user.slack_id)
        attrs = { 'slack_name' => response.user.name }
        attrs.merge!(response.user.profile.to_h.slice('email', 'first_name', 'last_name'))
        user.update(attrs)
      end
    end
  end
end
