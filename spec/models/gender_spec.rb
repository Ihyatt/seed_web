require 'rails_helper'

RSpec.describe Gender, type: :model do
  let(:gender) { FactoryGirl.build(:gender) }

  subject { gender }
  
  describe "associations" do
    it { should have_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
