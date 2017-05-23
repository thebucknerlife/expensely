class CreateAndDeliverBatchService

  def initialize(
    pdf_creator: RequestsPdfCreatorService.new,
    zip_creator: ZipCreatorService.new,
    uploader: PDFUploadService.new,
    mailer: BatchMailer
  )
    @pdf_creator = pdf_creator
    @zip_creator = zip_creator
    @uploader = uploader
    @mailer = mailer
  end

  def run(team:)
    batch = Batch.new(team: team)

    uploads = team.users.map do |user|
      requests = user.requests.submitted.undelivered
      batch.requests << requests
      next unless requests.any?
      rails_path  = pdf_creator.create_and_save(requests)
      upload(rails_path, user)
    end

    public_ids = uploads.compact.map(&:public_id)
    zip = zip_creator.create_and_save(public_ids: public_ids, team: team, batch: batch)

    deliver_batch_email(zip.secure_url, batch)

    batch.requests.update_all(delivered_at: Time.now)
    batch.save
    #return deliver_no_requests_email(team) unless batch.requests.any?
  end

  private

  attr_reader :mailer, :uploader, :pdf_creator, :zip_creator

  def upload(rails_path, user)
    uploader.upload(rails_path: rails_path, user: user, team: user.team)
  end


  def deliver_batch_email(zip_url, batch)
    mailer.requests_batch_email(zip_url, batch).deliver_now
  end

  #def deliver_no_requests_email(team)
    #mailer.no_requests_email(team).deliver_now
  #end
end
