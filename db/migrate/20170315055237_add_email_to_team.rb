class AddEmailToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :email, :string
  end
end
