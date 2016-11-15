require 'rails_helper'

RSpec.describe Officer, type: :model do
  let(:incident)   { FactoryGirl.build(:incident) }
  let(:officer) { FactoryGirl.create(:officer, incident: incident) }
  
  subject { officer }

  describe "associations" do
    it { should belong_to(:incident) }
    it { should belong_to(:race) }
    it { should belong_to(:gender) }
  end

  describe 'validations' do
    it { should validate_presence_of(:incident) }
  end
  
end
