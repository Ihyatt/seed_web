require 'rails_helper'

RSpec.describe IncidentQuery, type: :model do
  let(:incident_query) { FactoryGirl.build(:incident_query) }
  let(:reaction) { FactoryGirl.create(:reaction) }
  let(:reaction2) { FactoryGirl.create(:reaction) }

  let(:tag) { FactoryGirl.create(:tag) }
  let(:tag2) { FactoryGirl.create(:tag) }
  
  subject { incident_query }

  describe "associations" do
    
  end

  describe 'validations' do

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

    it "should search completed incidents" do
      incident_query = IncidentQuery.search_by(completed: true)
      incidents = incident_query.incidents

      expect(incident_query).to be_present
      expect(incident_query.completed).to eq true
      expect(incident_query.total_count).to eq incidents.count
      expect(incident_query.negative_count).to eq incidents.negative.count
      expect(incident_query.positive_count).to eq incidents.positive.count

      expect(incidents.first).to eq(completed_incident)
    end

    # it "should search incomplete incidents" do
    #   incidents = IncidentQuery.search_by(completed: false)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

    # it "should search incomplete or complete incidents" do
    #   incidents = IncidentQuery.search_by(completed: nil)

    #   expect(incidents.count).to eq(2)
    # end

    it "should search by reactions" do
      incident_query = IncidentQuery.search_by(reactions: "#{reaction.name},   foo")
      incidents = incident_query.incidents

      expect(incident_query).to be_present
      expect(incident_query.reactions).to eq "#{reaction.name}, foo"
      expect(incident_query.total_count).to eq incidents.count
      expect(incident_query.negative_count).to eq incidents.negative.count
      expect(incident_query.positive_count).to eq incidents.positive.count

      expect(incidents.first).to eq(incident)
    end

    it "should search by tags" do
      incident_query = IncidentQuery.search_by(tags: "#{tag.name},   foo")
      incidents = incident_query.incidents

      expect(incident_query).to be_present
      expect(incident_query.tags).to eq "#{tag.name}, foo"
      expect(incident_query.total_count).to eq incidents.count
      expect(incident_query.negative_count).to eq incidents.negative.count
      expect(incident_query.positive_count).to eq incidents.positive.count

      expect(incidents.first).to eq(incident)
    end

    # it "should search by incident_type" do
    #   incidents = IncidentQuery.search_by(incident_type_id: incident_type.id)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

    it "should search by single rating" do
      incident_query = IncidentQuery.search_by(ratings: "1")
      incidents = incident_query.incidents

      expect(incident_query).to be_present
      expect(incident_query.ratings).to eq "1"
      expect(incident_query.total_count).to eq incidents.count
      expect(incident_query.negative_count).to eq incidents.negative.count
      expect(incident_query.positive_count).to eq incidents.positive.count

      expect(incidents.first).to eq(incident)
    end

    it "should search by multiple rating" do
      incident_query = IncidentQuery.search_by(ratings: "1 ,  5")
      incidents = incident_query.incidents

      expect(incident_query).to be_present
      expect(incident_query.ratings).to eq "1, 5"
      expect(incident_query.total_count).to eq incidents.count
      expect(incident_query.negative_count).to eq incidents.negative.count
      expect(incident_query.positive_count).to eq incidents.positive.count

      expect(incidents.count).to eq(2)
      expect(incidents.first).to eq(incident)
      expect(incidents.last).to eq(completed_incident)
    end

    # it "should search between start time and end_time" do
    #   incidents = IncidentQuery.search_by(start_time:Time.zone.now, end_time: Time.zone.now + 1.day)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

    # it "should search after start time" do
    #   incidents = IncidentQuery.search_by(start_time:Time.zone.now)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

    # it "should search by place" do
    #   incidents = IncidentQuery.search_by(place_id: neighborhood.id)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

    # it "should search by a place's direct children" do
    #   incidents = IncidentQuery.search_by(place_id: city.id)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

    # it "should search by a place's children" do
    #   incidents = IncidentQuery.search_by(place_id: state.id)

    #   expect(incidents.count).to eq(1)
    #   expect(incidents.first).to eq(incident)
    # end

  end
end
