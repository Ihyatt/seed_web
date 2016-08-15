FactoryGirl.define do
  factory :message do
    conversation
    user
    text {Faker::Lorem.sentence}
    platform "web"
  end
end
