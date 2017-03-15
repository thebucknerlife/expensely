class CreateAndDeliverBatchService

  def initialize(uploader: Cloudinary::Uploader, pdf_generator: RequestsPdfGenerator.new, mailer: BatchMailer)
    @uploader = uploader
    @pdf_generator = pdf_generator
    @mailer = mailer
  end

  def run(team:, requests:)
    batch = Batch.new(team: team, requests: requests.includes(:user, :request_items))
    return deliver_no_requests_email(team) unless batch.requests.any?
    zip_url = create_zip(batch)
    pdf = create_pdf_file(batch)
    pdf_url = upload_and_record_pdf(pdf, batch)
    deliver_batch_email(zip_url, pdf_url, batch)
  end

  private

  attr_reader :uploader, :pdf_generator, :mailer

  def create_zip(batch)
    response = uploader.create_zip(zip_args(batch))
    response['secure_url']
  end

  def create_pdf_file(batch)
    File.open(pdf_save_path, 'wb') do |f|
      f << pdf_generator.generate(batch.requests)
    end
  end

  def upload_and_record_pdf(pdf, batch)
    response = uploader.upload(File.open(pdf_save_path), pdf_args)
    batch.update(cloudinary_json: response)
    response['secure_url']
  end

  def zip_args(batch)
    receipt_image_ids = batch.requests.flat_map {|r| r.request_items.map{|ri| ri.receipt.cloudinary_json['public_id']}}
    {
      public_ids: receipt_image_ids,
      transformations: ['/w_1000,h_1000,c_limit'],
      target_public_id: 'test',
      tags: ['batch-zip']
    }
  end

  def pdf_args
    {
      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
      api_key: ENV['CLOUDINARY_API_KEY'],
      api_secret: ENV['CLOUDINARY_API_SECRET'],
      tags: ['batch-pdf'],
    }
  end

  def pdf_save_path
    @path ||= Rails.root.join('public', "#{Time.now.to_i}.pdf")
  end

  def deliver_batch_email(zip_url, pdf_url, batch)
    mailer.requests_batch_email(zip_url, pdf_url, batch)
  end

  def deliver_no_requests_email(team)
    mailer.no_requests_email(team)
  end
end
