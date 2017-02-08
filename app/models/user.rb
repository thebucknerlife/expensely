class User < ApplicationRecord
  attr_accessor :new

  has_many :requests, dependent: :destroy

  alias_method :new?, :new
end
