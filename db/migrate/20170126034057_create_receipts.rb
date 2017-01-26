class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|
      t.references :request_item, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
