class User < ApplicationRecord
  attr_accessor :new

  has_many :requests, dependent: :destroy
  belongs_to :team, optional: true

  alias_method :new?, :new
end
