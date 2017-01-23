class AddNameToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :name, :string
  end
end
