class ZipCreatorService

  def initialize(uploader: Cloudinary::Uploader)
    @uploader = uploader
  end

  def create_and_save(public_ids:, filename: nil, tags: [], team: nil, user: nil, receipt: nil, batch: nil)
    args = zip_args(public_ids, filename, tags)
    response = uploader.create_zip(args)
    create(response, team, user, receipt, batch)
  end

  private

  attr_reader :uploader

  def create(response, team, user, receipt, batch)
    attrs = rename_cloudinary_reserved_keys(response)
    attrs.merge!(team: team, user: user, receipt: receipt, batch: batch)
    CloudinaryUpload.create!(attrs)
  end

  def rename_cloudinary_reserved_keys(response)
    CloudinaryUpload.rename_cloudinary_reserved_keys(response)
  end

  def zip_args(public_ids, filename, tags)
    args = {
      public_ids: public_ids,
      transformations: image_transformations,
      target_tags: zip_tags(tags)
    }
    args.merge!(target_public_id: filename) if filename
    args
  end

  def image_transformations
    ['/w_1000,h_1000,c_limit']
  end

  def zip_tags(tags)
    ['zip'].concat(tags)
  end
end
