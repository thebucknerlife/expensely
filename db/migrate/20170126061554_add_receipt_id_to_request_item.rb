class AddReceiptIdToRequestItem < ActiveRecord::Migration[5.0]
  def change
    add_column :request_items, :receipt_id, :integer
  end
end
