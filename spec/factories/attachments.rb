FactoryGirl.define do
  factory :attachment do
    incident
    asset { File.new("#{Rails.root}/spec/support/fixtures/image.png") }
  end
end
