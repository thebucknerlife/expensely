class Request < ApplicationRecord
  belongs_to :user
  has_many :request_items

  accepts_nested_attributes_for :request_items
end
