FactoryGirl.define do
  factory :conversation do
    customer { FactoryGirl.create(:user) }    
  end
end
