def stub_slack
  WebMock.stub_request(:post, "https://slack.com/api/users.info")
  .to_return(body: {
    "ok": true,
    "user": {
      "id": "UAU123",
      "name": "bobby",
      "profile": {
        "first_name": "Bobby",
        "last_name": "Tables",
        "real_name": "Bobby Tables",
        "email": "bobby@slack.com",
        "skype": "my-skype-name",
        "phone": "+1 (123) 456 7890",
      },
    }
  }.to_json)
end

RSpec.configure do |config|
  config.before(:each) do
    stub_slack
  end
end
