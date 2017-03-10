class CreateBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :batches do |t|
      t.string :slug
      t.integer :team_id

      t.timestamps
    end
  end
end
