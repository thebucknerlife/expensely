class AddEmailsArrayToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :emails, :string, array: true, default: '{}'
  end
end
