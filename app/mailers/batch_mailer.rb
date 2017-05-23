class BatchMailer < ApplicationMailer
  def requests_batch_email(zip_url, batch)
    @zip_url = zip_url
    mail(to: batch.team.email, subject: 'Reimbursements Batch')
  end

  def no_requests_email(team)
    mail(to: team.email, subject: 'Reimbursements Batch')
  end
end
