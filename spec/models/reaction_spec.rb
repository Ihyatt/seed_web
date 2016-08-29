require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let(:reaction) { FactoryGirl.build(:reaction) }
  
  subject { reaction }

  describe "associations" do
    
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }

  end
end
