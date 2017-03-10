class AddDeliveredAtToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :delivered_at, :datetime
  end
end
