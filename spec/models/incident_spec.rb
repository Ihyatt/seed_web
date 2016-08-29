require 'rails_helper'

RSpec.describe Incident, type: :model do
  let(:incident) { FactoryGirl.build(:incident) }

  subject { incident }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }

    it { should validate_presence_of(:user) }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).allow_nil }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5).allow_nil }
  end


  describe "reactions" do
    it "should be able to set reactions as array" do
      incident.reactions = ["safe", "scared"]
      incident.save

      expect(incident.reactions.count).to eq 2
      expect(incident.reactions).to include("safe")
      expect(incident.reactions).to include("scared")

      incidents = Incident.with_any_reactions("safe")
      expect(incidents.count).to eq(1)
    end

    it "should be able to set reactions as string" do
      incident.reactions_list = "safe, scared"
      incident.save

      expect(incident.reactions.count).to eq 2
      expect(incident.reactions).to include("safe")
      expect(incident.reactions).to include("scared")
    end

  end
end
