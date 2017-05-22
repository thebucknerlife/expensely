class CloudinaryUpload < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :user, optional: true
  belongs_to :batch, optional: true
  belongs_to :receipt, optional: true

  def self.rename_cloudinary_reserved_keys(attrs)
    attrs['cloudinary_type'] = attrs.delete('type')
    attrs['cloudinary_created_at'] = attrs.delete('created_at')
    attrs
  end
end
