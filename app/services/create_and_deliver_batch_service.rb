class CreateAndDeliverBatchService

  def run(team:, requests:)
    batch = Batch.new(team: team, requests: requests.includes(:user, :request_items))
    zip_url = create_zip(batch)
    pdf = create_pdf(batch)
    upload_and_record_pdf(pdf, batch)
    byebug
    puts "CreateAndDeliverBatchService #{batch.team.team_name} #{batch.request_ids}"
  end

  def create_zip(batch)
    receipt_image_ids = batch.requests.flat_map {|r| r.request_items.map{|ri| ri.receipt.cloudinary_json['public_id']}}
    response = Cloudinary::Uploader.create_zip(
      public_ids: receipt_image_ids,
      transformations: ['/w_1000,h_1000,c_limit'],
      target_public_id: 'test',
      tags: ['batch-zip']
    )
    response['public_url']
  end

  def create_pdf(batch)
    decorated = RequestsByUserDecorator.decorate(batch.requests)
    #html = ActionController::Base.new.render_to_string(:action => :index, :layout => "pdf")
    html = ApplicationController.render(template: 'requests/index', assigns: { decorated: decorated } )
    WickedPdf.new.pdf_from_string(html)
  end

  def upload_and_record_pdf(pdf, batch)
    save_path = Rails.root.join('public','temp', "#{Time.now.to_i}.pdf")
    file = File.open(save_path, 'wb') do |f|
      f << pdf
    end
    byebug
    response = Cloudinary::Uploader.upload(File.open(save_path), cloudinary_config.merge(tags: ['batch-pdf']))
    byebug
    batch.update(cloudinary_json: response)
    response['secure_url']
  end

  def cloudinary_config
    {
      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
      api_key: ENV['CLOUDINARY_API_KEY'],
      api_secret: ENV['CLOUDINARY_API_SECRET']
    }
  end
end
