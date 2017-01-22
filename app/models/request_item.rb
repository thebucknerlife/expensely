class RequestItem < ApplicationRecord
  belongs_to :request
  after_initialize :set_defaults

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
