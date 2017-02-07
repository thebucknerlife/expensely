require "rails_helper"
require "#{Rails.root}/bots/expensely"

RSpec.describe Expensely::Commands::Request do
  let(:client) { double }
  let(:match) { double }
  let!(:team_id) { Team.create(team_id: 'XYZ-987') }
  let!(:user_slack_id) { 'UAU123' }
  let(:subject) { described_class.call(client, data, match) }

  describe "call" do
    let(:data) { double(team:  'XYZ-987', user: user_slack_id, channel: "some-channel") }

    context "when user is returning" do
      let!(:user) { User.create(slack_id: user_slack_id) }

      it "should respond familiarily with a request url" do
        expect(client).to receive(:say).with(
          channel: "some-channel",
          text: "Receipts! My faaavorite. Let's get them uploaded here http://localhost:3000/requests/1"
        )
        subject
      end
    end

    context "when user is new" do
      it "should respond with a greeting and a request url" do
        expect(client).to receive(:say).with(
          channel: "some-channel",
          text: "hey hey hey, its time to balance the books Bobby! let's get you reimbursed http://localhost:3000/requests/2"
        )
        subject
      end
    end
  end
end
