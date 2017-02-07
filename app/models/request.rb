class Request < ApplicationRecord
  belongs_to :user
  has_many :request_items, dependent: :destroy

  accepts_nested_attributes_for :request_items

  scope :in_progress, -> { where(submitted_at: nil) }
  scope :submitted, -> { where.not(submitted_at: nil) }


  def new_request_url
    Rails.application.routes.url_helpers.request_url(id: id, host: ENV['HOST'])
  end
end
