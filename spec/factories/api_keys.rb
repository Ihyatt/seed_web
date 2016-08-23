FactoryGirl.define do
  factory :api_key do
<<<<<<< Updated upstream
    read_key SecureRandom.hex(16)
    write_key SecureRandom.hex(16)
    user
=======
    read_key "MyString"
    write_key "MyString"
>>>>>>> Stashed changes
  end
end
