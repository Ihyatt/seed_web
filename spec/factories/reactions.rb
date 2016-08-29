FactoryGirl.define do
  factory :reaction do
    name { FactoryGirl.generate(:name) }
  end
end
