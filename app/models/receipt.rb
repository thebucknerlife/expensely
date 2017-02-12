class Receipt < ApplicationRecord
  has_one :request_item
  #mount_uploader :image, ReceiptImageUploader

  def original_url
    cloudinary_json['url']
  end

  def url
    if pdf?
      pdf_to_image
    else
      cloudinary_json['url'].dup
    end
  end

  def pdf?
    original_url.match(/\.pdf$/)
  end

  def pdf_to_image
    original_url.gsub(/\.pdf$/,".jpeg")
  end

  def accountant_url
    @accountant_url ||= begin
      insert_pos = url.index(/\/upload/)+7
      url.insert(insert_pos, '/w_1000,h_1000,c_limit')
    end
  end

  def thumbnail_url
    @thumbnail ||= begin
      insert_pos = url.index(/\/upload/)+7
      url.insert(insert_pos, '/w_250,h_250,c_fit')
    end
  end
end
