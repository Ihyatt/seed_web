require 'rails_helper'

RSpec.describe IncidentType, type: :model do
  let(:incident_type) { FactoryGirl.build(:incident_type) }

  subject { incident_type }

  describe "associations" do
    it { should have_many :incidents }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
