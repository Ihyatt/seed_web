FactoryGirl.define do
  factory :place do
    name  { FactoryGirl.generate(:city) }
    level Place::CITY
  end
end
