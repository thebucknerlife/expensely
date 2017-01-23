class RequestItem < ApplicationRecord
  belongs_to :request
  after_initialize :set_defaults

  default_scope { order(created_at: :desc) }

  def defaults
    {
      description: '',
      category: '',
      amount: 0
    }
  end

  def set_defaults
    defaults.each do |default, val|
      self.send(default) || self.send("#{default}=", val)
    end
  end
end
