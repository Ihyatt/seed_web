FactoryGirl.define do
  factory :user, class: User do
    email { FactoryGirl.generate(:email) }
    password "testtest"
    password_confirmation {|u| u.password }
  end
end