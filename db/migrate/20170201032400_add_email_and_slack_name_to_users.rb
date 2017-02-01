class AddEmailAndSlackNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email, :string
    add_column :users, :slack_name, :string
  end
end
