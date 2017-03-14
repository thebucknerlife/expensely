class AddCloudinaryJsonToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :cloudinary_json, :json
  end
end
