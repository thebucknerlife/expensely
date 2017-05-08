class ZipService

  def initialize(uploader: Cloudinary::Uploader)
    @uploader = uploader
  end

  def run(public_ids:, filename: nil, tags: [])
    args = zip_args(public_ids, filename, tags)
    response = uploader.create_zip(args)
    response['secure_url']
  end

  private

  attr_reader :uploader

  def zip_args(public_ids, filename, tags)
    args = {
      public_ids: public_ids,
      transformations: image_transformations,
      tags: zip_tags(tags)
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
