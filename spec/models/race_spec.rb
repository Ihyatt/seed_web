require 'rails_helper'

RSpec.describe Race, type: :model do
  let(:race) { FactoryGirl.build(:race) }

  subject { race }

  describe "associations" do
    it { should have_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
