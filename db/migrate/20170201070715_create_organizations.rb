class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.json :slack_token_json
      t.string :team_name
      t.string :team_id

      t.timestamps
    end
  end
end
