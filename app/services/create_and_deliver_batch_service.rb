class CreateAndDeliverBatchService

  def initialize()

  end

  def run(team:, requests:)
    batch = Batch.new(team: team, requests: requests.includes(:user, :request_items))
    zip_url = create_zip(batch)
    pdf_url = create_pdf(batch)
    puts "CreateAndDeliverBatchService #{batch.team.team_name} #{batch.request_ids}"
  end

  def create_zip(batch)
    receipt_image_ids = batch.requests.flat_map {|r| r.request_items.map{|ri| ri.receipt.cloudinary_json['public_id']}}
    response = Cloudinary::Uploader.create_zip(
      public_ids: receipt_image_ids,
      transformations: ['/w_1000,h_1000,c_limit'],
      target_public_id: 'test',
    )
    response['public_url']
  end

  def create_pdf(batch)
    decorated = RequestsByUserDecorator.decorate(batch.requests)
    html = render_to_string(:action => :index, :layout => "pdf")
    pdf = WickedPdf.new.pdf_from_string(html)
    # upload?

    #send_data(pdf,
              #:filename => "requests-#{Time.now.strftime("%m-%e-%y-%H:%M:%S")}.pdf",
              #:disposition => 'attachment')
  end
end
