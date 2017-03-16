class AddCloudinaryPublicIdToReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :receipts, :cloudinary_public_id, :string
  end
end
