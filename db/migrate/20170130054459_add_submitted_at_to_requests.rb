class AddSubmittedAtToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :submitted_at, :datetime
  end
end
