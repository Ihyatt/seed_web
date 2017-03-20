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
    it { should belong_to :religion }
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

  describe "setters" do
    it "should support setting race by name" do
      Race.seed
      race = Race.first
      user.race_name = race.name
      user.save

      expect(user.race_id).to eq race.id
    end

    it "should support setting gender by name" do
      Gender.seed
      gender = Gender.first
      user.gender_name = gender.name
      user.save

      expect(user.gender_id).to eq gender.id
    end

    it "should support setting religion by name" do
      Religion.seed
      religion = Religion.first
      user.religion_name = religion.name
      user.save

      expect(user.religion_id).to eq religion.id
    end
  end
end
