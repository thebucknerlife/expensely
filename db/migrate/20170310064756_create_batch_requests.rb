class CreateBatchRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :batch_requests do |t|
      t.references :batch, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
