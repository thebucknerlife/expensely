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
