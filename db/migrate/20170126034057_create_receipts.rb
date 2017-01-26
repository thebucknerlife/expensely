class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|
      t.integer :request_item_id
      t.string :image
      t.json :cloudinary_json

      t.timestamps
    end
  end
end
