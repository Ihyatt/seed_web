require 'rails_helper'

RSpec.describe Attachment, type: :model do
  let(:incident)   { FactoryGirl.build(:incident) }
  let(:attachment) { FactoryGirl.create(:attachment, incident: incident) }
  
  subject { attachment }

  describe "associations" do
    it { should belong_to(:incident) }
  end

  describe 'validations' do
    it { should validate_presence_of(:incident) }
  end
  
end
