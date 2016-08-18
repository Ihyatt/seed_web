FactoryGirl.define do
  factory :user, class: User do
    email { FactoryGirl.generate(:email) }
    password "testtest"
    password_confirmation {|u| u.password }
  

    factory :admin do
      after(:build) {|user| user.add_role :admin }
    end

  end
end