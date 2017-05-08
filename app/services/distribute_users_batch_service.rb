class CreateAndDeliverBatchService

  def initialize(uploader: Cloudinary::Uploader, pdf_generator: RequestsPdfGenerator.new, mailer: BatchMailer)
    @uploader = uploader
    @pdf_generator = pdf_generator
    @mailer = mailer
  end

  def run(team:, requests:)
    batch = Batch.new(team: team)
    return deliver_no_requests_email(team) unless batch.requests.any?

    pdf_public_ids = team.users.map do |user|
      requests = user.requests.submitted.undelivered
      return unless requests.any?

      pdf = create_pdf_file(user, requests)
      upload_pdf(pdf_file, team, user)
    end

    zip_url = create_zip(
      public_ids: pdf_public_ids,
      filename: "reimbursements_#{team.id}_#{DateTime.now.to_i}",
      tags: ['batch-by-users-zip']
    )
    deliver_batch_email(zip_url, batch)
    batch.requests.update_all(delivered_at: Time.now)
    batch.save
  end

  private

  attr_reader :uploader, :pdf_generator, :mailer

  #def create_zip(batch)
    #response = uploader.create_zip(zip_args(batch))
    #response['secure_url']
  #end

  def create_pdf_file(user, requests)
    File.open(pdf_save_path, 'wb') do |f|
      f << pdf_generator.generate(user, requests)
    end
  end

  def upload_and_record_pdf(pdf)
    response = uploader.upload(File.open(pdf_save_path), pdf_args)
    response['secure_url']
  end

  def pdf_args
    {
      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
      api_key: ENV['CLOUDINARY_API_KEY'],
      api_secret: ENV['CLOUDINARY_API_SECRET'],
      tags: ['batch-pdf'],
    }
  end

  def pdf_save_path(user)
    @path ||= Rails.root.join('public', "#{Time.now.to_i}.pdf")
  end

  def timestamp
    @timestamp ||= Time.now.to_i
  end

  #def deliver_batch_email(zip_url, pdf_url, batch)
    #mailer.requests_batch_email(zip_url, pdf_url, batch).deliver_now
  #end

  def deliver_no_requests_email(team)
    mailer.no_requests_email(team).deliver_now
  end
end
