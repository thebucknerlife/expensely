class BatchRequest < ApplicationRecord
  belongs_to :batch
  belongs_to :request
end
