require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Officers" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  let!(:incident) { FactoryGirl.create(:incident, user: user) }
  
  before(:all) do
    Race.seed
    Gender.seed
  end

  post "/api/v1/officers" do
    parameter :incident_id, "Incident ID", required: true
    parameter :name, "Officer's name"
    parameter :description, "Description"
    parameter :badge_number, "Badge Number"
    parameter :race_id, "Race ID"
    parameter :gender_id, "Gender ID"
    parameter :race_name, "Race ID"
    parameter :gender_name, "Gender ID"
    parameter :age_estimate, "Estimate of Age"

    
    example "Add Officer to Incident" do
      name = "Officer"
      badge_number = "123"
      description = "not nice"
      race = Race.first
      gender = Gender.first
      age_estimate = "20-30"

      do_request( incident_id: incident.id,
                  name: name,
                  badge_number: badge_number,
                  description: description,
                  race_id: race.id,
                  gender_id: gender.id,
                  age_estimate: age_estimate,
                  write_key: api_key.write_key)

      expect(status).to eq(200)
      
      # get the newly created officer
      officer = Officer.last

      json = JSON.parse(response_body)
      # json.should == ""

      officer_json = json["data"]
    
      expect(officer_json["id"]).to eq(officer.id)
      expect(officer_json["incident_id"]).to eq(incident.id)
      expect(officer_json["name"]).to eq(name)
      expect(officer_json["badge_number"]).to eq(badge_number)
      expect(officer_json["age_estimate"]).to eq(age_estimate)
      expect(officer_json["description"]).to eq(description)
      expect(officer_json["race_id"]).to eq(race.id)
      expect(officer_json["gender_id"]).to eq(gender.id)

      expect(officer_json["created_at"]).not_to be_nil
      expect(officer_json["updated_at"]).not_to be_nil
    end
  
    example "Add Officer to Incident by Race, Gender Name" do
      name = "Officer"
      badge_number = "123"
      description = "not nice"
      race = Race.first
      gender = Gender.first
      age_estimate = "20-30"

      do_request( incident_id: incident.id,
                  name: name,
                  badge_number: badge_number,
                  description: description,
                  race_name: race.name,
                  gender_name: gender.name,
                  age_estimate: age_estimate,
                  write_key: api_key.write_key)

      expect(status).to eq(200)
      
      # get the newly created officer
      officer = Officer.last

      json = JSON.parse(response_body)
      # json.should == ""

      officer_json = json["data"]
    
      expect(officer_json["id"]).to eq(officer.id)
      expect(officer_json["incident_id"]).to eq(incident.id)
      expect(officer_json["name"]).to eq(name)
      expect(officer_json["badge_number"]).to eq(badge_number)
      expect(officer_json["age_estimate"]).to eq(age_estimate)
      expect(officer_json["description"]).to eq(description)
      expect(officer_json["race_id"]).to eq(race.id)
      expect(officer_json["gender_id"]).to eq(gender.id)

      expect(officer_json["created_at"]).not_to be_nil
      expect(officer_json["updated_at"]).not_to be_nil
    end
  end

  put "/api/v1/officers/:id.json" do
    parameter :officer_id, "Officer ID", required: true
    parameter :name, "Officer's name"
    parameter :description, "Description"
    parameter :badge_number, "Badge Number"
    parameter :race_id, "Race ID"
    parameter :gender_id, "Gender ID"

    example "Update Officer" do
      officer = FactoryGirl.create(:officer, incident: incident)

      name = "Officer Bob"
      badge_number = "123"
      description = "not nice"
      race_id = Race.first.id
      gender_id = Gender.first.id

      do_request( id: officer.id,
                  name: name,
                  badge_number: badge_number,
                  description: description,
                  race_id: race_id,
                  gender_id: gender_id,
                  write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      # json.should == ""

      officer_json = json["data"]
    
      expect(officer_json["id"]).to eq(officer.id)
      expect(officer_json["incident_id"]).to eq(incident.id)
      expect(officer_json["name"]).to eq(name)
      expect(officer_json["badge_number"]).to eq(badge_number)
      expect(officer_json["description"]).to eq(description)
      expect(officer_json["race_id"]).to eq(race_id)
      expect(officer_json["gender_id"]).to eq(gender_id)

      expect(officer_json["created_at"]).not_to be_nil
      expect(officer_json["updated_at"]).not_to be_nil
    end
  end
end