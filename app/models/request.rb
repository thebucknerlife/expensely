class Request < ApplicationRecord
  has_secure_token

  belongs_to :user
  has_many :request_items, dependent: :destroy

  accepts_nested_attributes_for :request_items, allow_destroy: true

  scope :in_progress, -> { where(submitted_at: nil) }
  scope :submitted, -> { where.not(submitted_at: nil) }
  scope :undelivered, -> { where(delivered_at: nil) }
  scope :delivered, -> { where.not(delivered_at: nil) }
  scope :approved, -> { where('delivered_at < ?', 5.days.ago) }


  def new_request_url
    Rails.application.routes.url_helpers.request_url(id: id, host: ENV['HOST'], token: token)
  end

  def submitted?
    submitted_at?
  end
end
