require 'rails_helper'

RSpec.describe Incident, type: :model do
  let(:incident) { FactoryGirl.build(:incident) }
  let(:reaction) { FactoryGirl.create(:reaction) }
  let(:reaction2) { FactoryGirl.create(:reaction) }

  let(:tag) { FactoryGirl.create(:tag) }
  let(:tag2) { FactoryGirl.create(:tag) }

  subject { incident }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:incident_type) }
    it { should belong_to(:place) }
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

    it "should be valid only with approved tags" do
      incident.tags = [tag.name, tag2.name]
      incident.save

      expect(incident).to be_valid

      incident.tags = ["foo"]
      expect(incident).not_to be_valid

      incident.tags_list = "bar, dog"
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

  describe "tags" do
    it "should be able to set tags as array" do
      incident.tags = [tag.name, tag2.name]
      incident.save

      expect(incident.tags.count).to eq 2
      expect(incident.tags).to include(tag.name)
      expect(incident.tags).to include(tag2.name)

      incidents = Incident.with_any_tags(tag.name)
      expect(incidents.count).to eq(1)
    end

    it "should be able to set tags as string" do
      incident.tags_list = "#{tag.name}, #{tag2.name}"
      incident.save

      expect(incident.tags.count).to eq 2
      expect(incident.tags).to include(tag.name)
      expect(incident.tags).to include(tag2.name)
    end

  end


  describe "search" do
    let!(:user)     { FactoryGirl.create(:user) }
    let!(:incident_type) { FactoryGirl.create(:incident_type) }
    let!(:state) { FactoryGirl.create(:place, level: Place::STATE, name: "California") }
    let!(:city) { FactoryGirl.create(:place, level: Place::CITY, name: "San Francisco", parent: state) }
    let!(:neighborhood) { FactoryGirl.create(:place, level: Place::NEIGHBORHOOD, name: "Noe Valley", parent: city) }
    let!(:incident) { FactoryGirl.create(:incident, user: user, reactions: [reaction.name], 
                      tags: [tag.name], incident_type: incident_type, 
                      start_time: Time.zone.now + 4.hours, rating: 1,
                      place: neighborhood) }

    let!(:completed_incident) { FactoryGirl.create(:incident, completed: true, rating: 5) }

    it "should search incidents by user" do
      incident2 = FactoryGirl.create(:incident)

      incidents = Incident.search_by(user_id: user.id)

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
      incidents = Incident.search_by(reactions: "#{reaction.name},foo")

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by tags" do
      incidents = Incident.search_by(tags: "#{tag.name},foo")

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by incident_type" do
      incidents = Incident.search_by(incident_type_id: incident_type.id)

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by single rating" do
      incidents = Incident.search_by(ratings: "1")

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by multiple rating" do
      incidents = Incident.search_by(ratings: "1,5")

      expect(incidents.count).to eq(2)
      expect(incidents.first).to eq(incident)
      expect(incidents.last).to eq(completed_incident)
    end

    it "should search between start time and end_time" do
      incidents = Incident.search_by(start_time:Time.zone.now, end_time: Time.zone.now + 1.day)

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search after start time" do
      incidents = Incident.search_by(start_time:Time.zone.now)

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by place" do
      incidents = Incident.search_by(place_id: neighborhood.id)

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by a place's direct children" do
      incidents = Incident.search_by(place_id: city.id)

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

    it "should search by a place's children" do
      incidents = Incident.search_by(place_id: state.id)

      expect(incidents.count).to eq(1)
      expect(incidents.first).to eq(incident)
    end

  end

  describe "scopes" do
    it "should return incidents without_address" do
      incidents = Incident.without_address
      expect(Incident.without_address.count).to eq 0
    end

    it "should return incidents with_coordinates" do
      incident.latitude = 37.743424
      incident.longitude = -122.428573
      incident.save
      incidents = Incident.with_coordinates
      expect(incidents.count).to eq 1
      expect(incidents.first).to eq incident
    end
  end

  describe "setters" do
    it "should support setting incident_type by name" do
      IncidentType.seed
      incident_type = IncidentType.first
      incident.incident_type_name = incident_type.name
      incident.save

      expect(incident.incident_type_id).to eq incident_type.id
    end
  end
end