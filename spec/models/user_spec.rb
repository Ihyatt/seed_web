require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  describe "associations" do
    it { should have_many :messages }
    it { should have_many :api_keys }
    it { should belong_to :race }
    it { should belong_to :gender }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:uid) }
  end
end
