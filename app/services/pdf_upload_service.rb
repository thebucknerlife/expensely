class PDFUploadService

  def initialize(uploader: Cloudinary::Uploader)
    @uploader = uploader
  end

  def upload(rails_path:, filename: nil, tags: [], team: nil, user: nil, batch: nil)
    file = open_file(rails_path)
    args = pdf_args(filename, tags, team, user)

    response = uploader.upload(file, args)
    create(response, team, user, batch)
  end

  private

  attr_reader :uploader


  def create(response, team, user, batch)
    attrs = rename_cloudinary_reserved_keys(response)
    attrs.merge!(team: team, user: user, batch: batch)
    # TODO: handle extra attributes (like "pages")
    byebug
    CloudinaryUpload.create!(attrs)
  end

  def rename_cloudinary_reserved_keys(response)
    CloudinaryUpload.rename_cloudinary_reserved_keys(response)
  end

  def open_file(rails_path)
    path = Rails.root.join(rails_path)
    File.open(path)
  end

  def pdf_args(filename, tags, team, user)
    args = {
      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
      api_key: ENV['CLOUDINARY_API_KEY'],
      api_secret: ENV['CLOUDINARY_API_SECRET'],
      tags: pdf_tags(tags, team),
      context: pdf_context(team, user)
    }
    args.merge!(public_id: filename) if filename
    args
  end

  def pdf_tags(tags, team)
    pdf_tags = ['pdf', Rails.env].concat(tags)
    pdf_tags.push("team-#{team.id}") if team
    pdf_tags.uniq
  end

  def pdf_context(team, user)
    {
      team: team&.team_name,
      team_id: team&.id,
      user_id: user&.id,
    }
  end
end
