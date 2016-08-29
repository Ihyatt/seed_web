require 'rails_helper'

RSpec.describe Incident, type: :model do
  let(:incident) { FactoryGirl.build(:incident) }

  subject { incident }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }

    it { should validate_presence_of(:user) }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).allow_nil }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5).allow_nil }
  end


end
