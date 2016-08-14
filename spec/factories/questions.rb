FactoryGirl.define do
  factory :question do
    title {Faker::Lorem.sentence}
    survey
  end
end
