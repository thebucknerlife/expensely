class CreateCloudinaryUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :cloudinary_uploads do |t|
      t.integer :team_id
      t.integer :user_id
      t.integer :receipt_id
      t.integer :batch_id
      t.string :public_id
      t.string :signature
      t.integer :version
      t.string :width
      t.string :height
      t.string :format
      t.string :resource_type
      t.datetime :cloudinary_created_at
      t.string :tags, array: true
      t.integer :bytes
      t.string :cloudinary_type
      t.string :etag
      t.string :url
      t.string :secure_url
      t.string :original_filename
      t.integer :resource_count
      t.integer :file_count

      t.timestamps
    end
  end
end
