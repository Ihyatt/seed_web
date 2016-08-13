require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  describe "associations" do
    it { should have_many :messages }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:uid) }
  end
end
