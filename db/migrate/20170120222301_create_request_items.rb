class CreateRequestItems < ActiveRecord::Migration[5.0]
  def change
    create_table :request_items do |t|
      t.references :request, foreign_key: true
      t.string :description
      t.string :category
      t.integer :amount

      t.timestamps
    end
  end
end
