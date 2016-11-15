require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  describe "associations" do
    it { should have_many :messages }
    it { should have_many :api_keys }
    it { should have_many :incidents }
    it { should belong_to :race }
    it { should belong_to :gender }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:uid) }
  end

  describe "generate" do
    it "should generate a user from a facebook_id" do
      facebook_id = FactoryGirl.generate(:bitcoin_address)

      user = User.generate(facebook_id)

      expect(user).not_to be_nil
      expect(user).to be_persisted
      expect(user.facebook_id).to eq(facebook_id)
    end

    it "should return same user from facebook_id" do
      facebook_id = FactoryGirl.generate(:bitcoin_address)

      user = User.generate(facebook_id)
      user2 = User.generate(facebook_id)

      expect(user).to eq(user2)
    end
  end
end
