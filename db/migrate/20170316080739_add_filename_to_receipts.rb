class AddFilenameToReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :filename, :string
  end
end
