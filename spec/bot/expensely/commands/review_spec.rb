require "rails_helper"
require "#{Rails.root}/bots/expensely"

RSpec.describe Expensely::Commands::Review do
  let(:client) { double }
  let(:match) { double }
  let!(:team_id) { Team.create(team_id: 'XYZ-987') }
  let!(:user) { User.create(slack_id: user_slack_id) }
  let!(:requests) do
    user.requests.create(submitted_at: 1.days.ago)
    user.requests.create(submitted_at: 3.days.ago)
    user.requests.create(submitted_at: 20.days.ago)
  end
  let(:user_slack_id) { 'UAU123' }
  let(:data) { double(team:  'XYZ-987', user: user_slack_id, channel: "some-channel") }
  let(:subject) { described_class.call(client, data, match) }

  describe "call" do

    context "when something is up" do
      it "should respond familiarily with a request url" do
        expect(client).to receive(:say).with(
          channel: "some-channel",
          text: "Requests"
        )
        subject
      end
    end
  end
end
