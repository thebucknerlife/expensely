class User < ApplicationRecord
  attr_accessor :newly_created

  has_many :requests, dependent: :destroy
end
