# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require_relative 'bots/expensely'

Thread.abort_on_exception = true
Thread.new do
  Expensely::App.start_teams
end

run Rails.application
