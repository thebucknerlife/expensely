class Batch < ApplicationRecord
  belongs_to :team
  has_many :batch_requests
  has_many :requests, through: :batch_requests
end
