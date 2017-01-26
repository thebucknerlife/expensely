class Receipt < ApplicationRecord
  has_one :request_item
  #mount_uploader :image, ReceiptImageUploader

  def url
    cloudinary_json['url']
  end
end
