FactoryGirl.define do
  factory :request do
    user
    submitted_at nil
    delivered_at nil
  end
end
