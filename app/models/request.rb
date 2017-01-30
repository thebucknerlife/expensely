class Request < ApplicationRecord
  belongs_to :user
  has_many :request_items

  accepts_nested_attributes_for :request_items

  scope :in_progress, -> { where(submitted_at: nil) }
  scope :submitted, -> { where.not(submitted_at: nil) }
end
