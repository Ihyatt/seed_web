require 'rails_helper'

RSpec.describe Incident, type: :model do
  let(:incident) { FactoryGirl.build(:incident) }
  let(:reaction) { FactoryGirl.create(:reaction) }
  let(:reaction2) { FactoryGirl.create(:reaction) }

  subject { incident }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:incident_type) }
    it { should have_many(:attachments).dependent(:destroy) }
    it { should have_many(:officers).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }

    it { should validate_presence_of(:user) }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).allow_nil }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5).allow_nil }

    it "should be valid only with approved reactions" do
      incident.reactions = [reaction.name, reaction2.name]
      incident.save

      expect(incident).to be_valid

      incident.reactions = ["foo"]
      expect(incident).not_to be_valid

      incident.reactions_list = "bar, dog"
      expect(incident).not_to be_valid
    end
  end


  describe "reactions" do
    it "should be able to set reactions as array" do
      incident.reactions = [reaction.name, reaction2.name]
      incident.save

      expect(incident.reactions.count).to eq 2
      expect(incident.reactions).to include(reaction.name)
      expect(incident.reactions).to include(reaction2.name)

      incidents = Incident.with_any_reactions(reaction.name)
      expect(incidents.count).to eq(1)
    end

    it "should be able to set reactions as string" do
      incident.reactions_list = "#{reaction.name}, #{reaction2.name}"
      incident.save

      expect(incident.reactions.count).to eq 2
      expect(incident.reactions).to include(reaction.name)
      expect(incident.reactions).to include(reaction2.name)
    end

  end


  describe "search",focus: true do
    let!(:user)     { FactoryGirl.create(:user) }
    let!(:incident_type) { FactoryGirl.create(:incident_type) }
    let!(:incident) { FactoryGirl.create(:incident, user: user, reactions: [reaction.name], incident_type: incident_type) }
    let!(:completed_incident) { FactoryGirl.create(:incident, completed: true) }

    it "should search incidents by user" do
      incident2 = FactoryGirl.create(:incident)

      incidents = Incident.search_by(user: user)
      expect(incidents.count).to eq(1)

      expect(incidents.first).to eq(incident)
    end

    it "should search completed incidents" do
      incidents = Incident.search_by(completed: true)
      expect(incidents.count).to eq(1)

      expect(incidents.first).to eq(completed_incident)
    end

    it "should search incomplete incidents" do
      incidents = Incident.search_by(completed: false)
      expect(incidents.count).to eq(1)

      expect(incidents.first).to eq(incident)
    end

    it "should search incomplete or complete incidents" do
      incidents = Incident.search_by(completed: nil)
      expect(incidents.count).to eq(2)
    end

    it "should search by reactions" do
      incidents = Incident.search_by(reactions: reaction.name)
      expect(incidents.count).to eq(1)

      expect(incidents.first).to eq(incident)
    end

    it "should search by incident_type" do
      incidents = Incident.search_by(incident_type: incident_type)
      expect(incidents.count).to eq(1)

      expect(incidents.first).to eq(incident)
    end
  end
end