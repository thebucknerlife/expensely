namespace :receipt do
  desc "Rename images to fit new filename scheme"
  task rename_all: :environment do
    Receipt.all.each do |receipt|
      basename = File.basename(receipt.filename, File.extname(receipt.filename))
      next if receipt.cloudinary_public_id == basename

      current_public_id = receipt.cloudinary_json['public_id']
      new_public_id = receipt.cloudinary_public_id
      puts [receipt.id, current_public_id, new_public_id].inspect
      response = Cloudinary::Uploader.rename(current_public_id, new_public_id)
      receipt.update(
        cloudinary_json: response,
        filename: "#{response['public_id']}.#{response['format']}"
      )
    end
  end
end
