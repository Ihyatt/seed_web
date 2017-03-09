require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { FactoryGirl.build(:tag) }
  
  subject { tag }

  describe "associations" do
    
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
