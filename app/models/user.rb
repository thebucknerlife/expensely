class User < ApplicationRecord
  has_many :requests, dependent: :destroy
end
