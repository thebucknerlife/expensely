class BatchMailer < ApplicationMailer
  def requests_batch_email(zip_url, email)
    @zip_url = zip_url
    mail(to: email, subject: 'Reimbursements Batch')
  end

  def no_requests_email(email)
    mail(to: email, subject: 'Reimbursements Batch')
  end
end
