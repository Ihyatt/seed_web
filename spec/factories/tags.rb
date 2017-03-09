FactoryGirl.define do
  factory :tag do
    name { FactoryGirl.generate(:name) }
  end
end
