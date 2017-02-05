class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.json :oauth_response
      t.string :team_name
      t.string :team_id
      t.string :access_token
      t.string :bot_access_token

      t.timestamps
    end
  end
end
