# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require_relative 'bots/expensely'

if ENV['RUN_BOT'] == 'true'
  Thread.abort_on_exception = true
  Thread.new do
    Expensely::App.start_teams
  end
end

run Rails.application
