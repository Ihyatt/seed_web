FactoryGirl.define do
  factory :api_key do
    read_key SecureRandom.hex(16)
    write_key SecureRandom.hex(16)
    user
  end
end
