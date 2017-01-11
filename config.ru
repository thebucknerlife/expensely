# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require ::File.expand_path('../bots/expensely', __FILE__)

Thread.abort_on_exception = true
Thread.new do
  Expensely.run
end

run Rails.application
