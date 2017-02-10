class Request < ApplicationRecord
  has_secure_token

  belongs_to :user
  has_many :request_items, dependent: :destroy

  accepts_nested_attributes_for :request_items, allow_destroy: true

  scope :in_progress, -> { where(submitted_at: nil) }
  scope :submitted, -> { where('submitted_at >= ?', 10.days.ago) }
  scope :approved, -> { where('submitted_at < ?', 10.days.ago) }


  def new_request_url
    Rails.application.routes.url_helpers.request_url(id: id, host: ENV['HOST'], token: token)
  end

  def submitted?
    submitted_at?
  end
end
