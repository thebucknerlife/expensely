class AddPaidAtToRequestItems < ActiveRecord::Migration[5.0]
  def change
    add_column :request_items, :paid_at, :date
  end
end
