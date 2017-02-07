require "rails_helper"
require "#{Rails.root}/bots/expensely"

RSpec.describe Expensely::Commands::Request do
  before do
    SlackRubyBot::Server.new
  end

  it 'says nice!' do
    expect(message: 'chill').to respond_with_slack_message('nice!')
  end
end
