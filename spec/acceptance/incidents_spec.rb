require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Incidents" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  let!(:incident) { FactoryGirl.create(:incident, user: user) }
  let(:reaction) { FactoryGirl.create(:reaction) }
  let(:reaction2) { FactoryGirl.create(:reaction) }
  
  get "/api/v1/incidents" do
    parameter :page, "Page of incidents"

    example "Get All Incidents" do
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      incidents = json["data"]
      expect(incidents.count).to eq(1)

      incident_json = incidents[0]
      expect(incident_json["id"]).to eq(incident.id)
      expect(incident_json["slug"]).to eq(incident.slug)
      expect(incident_json["description"]).to eq(incident.description)
      expect(incident_json["location"]).to eq(incident.location)
      expect(incident_json["reactions_list"]).to eq(incident.reactions_list)
      expect(incident_json["latitude"]).to eq(incident.latitude)
      expect(incident_json["longitude"]).to eq(incident.longitude)
      expect(incident_json["rating"]).to eq(incident.rating)

      expect(incident_json["created_at"]).not_to be_nil
      expect(incident_json["updated_at"]).not_to be_nil

      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(Incident.all.size)

    end
  end

  get "/api/v1/incidents/:id" do
    parameter :id, "Incident ID", required: true

    example "Get A Incident" do
      do_request(id: incident.id, write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      #json.should == ""

      incident_json = json["data"]
      expect(incident_json["id"]).to eq(incident.id)
      expect(incident_json["slug"]).to eq(incident.slug)
      expect(incident_json["description"]).to eq(incident.description)
      expect(incident_json["location"]).to eq(incident.location)
      expect(incident_json["reactions_list"]).to eq(incident.reactions_list)
      expect(incident_json["latitude"]).to eq(incident.latitude)
      expect(incident_json["longitude"]).to eq(incident.longitude)
      expect(incident_json["rating"]).to eq(incident.rating)

      expect(incident_json["created_at"]).not_to be_nil
      expect(incident_json["updated_at"]).not_to be_nil

    end

    example "Get A Incident With Error" do
      do_request(id: 1234, write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(404)
      expect(json["errors"][0]["message"]).to eq("Couldn't find Incident with 'id'=1234")
    end

    example "Get A Incident With Invalid Write Key" do
      do_request(id: 1234, write_key: "foo")
      json = JSON.parse(response_body)
      
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(403)
      expect(json["errors"][0]["message"]).to eq("Invalid Write Key")
    end
  end

  post "/api/v1/incidents" do
    parameter :user_id, "Incident Email", required: true
    parameter :description, "What happened"
    parameter :location, "City and State"
    parameter :reactions_list, "Reactions to incidents from approved Incdents"
    parameter :latitude, "Float of Latitude"
    parameter :longitude, "Float of longitude"
    parameter :rating, "Numeric rating of incident, 1-5"


    example "Create A Incident" do
      description =  "I was arrested"
      location = "San Francisco, CA"
      reactions_list = "#{reaction.name}, #{reaction2.name}"
      rating = 5
      do_request( user_id: user.id,
                  description: description,
                  location: location,
                  reactions_list: reactions_list,
                  rating: rating,
                  write_key: api_key.write_key)

      expect(status).to eq(200)
      
      # get the newly created incident
      incident = Incident.last

      json = JSON.parse(response_body)
      #json.should == ""

      incident_json = json["data"]
    
      expect(incident_json["id"]).to eq(incident.id)
      expect(incident_json["slug"]).to eq(incident.slug)
      expect(incident_json["description"]).to eq(description)
      expect(incident_json["location"]).to eq(location)
      expect(incident_json["reactions_list"]).to eq(incident.reactions_list)
      expect(incident_json["latitude"]).not_to be_nil
      expect(incident_json["longitude"]).not_to be_nil
      expect(incident_json["rating"]).to eq(rating)

      expect(incident_json["created_at"]).not_to be_nil
      expect(incident_json["updated_at"]).not_to be_nil
    end
  end

  put "/api/v1/incidents/:id.json" do
    parameter :id, "Incident ID", required: true
    parameter :description, "What happened"
    parameter :location, "City and State"
    parameter :reactions_list, "Reactions to incidents from approved Incdents"
    parameter :latitude, "Float of Latitude"
    parameter :longitude, "Float of longitude"
    parameter :rating, "Numeric rating of incident, 1-5"
    parameter :start_time, "When the incident occured in Epoch Time (seconds since 1970)"

    example "Update A Incident" do
      email = FactoryGirl.generate(:email)
      description =  "I was stopped"
      location = "New York, NY"
      reactions_list = "#{reaction.name}"
      rating = 1
      start_time = DateTime.now

      do_request( id: incident.id,
                  description: description,
                  location: location,
                  reactions_list: reactions_list,
                  rating: rating,
                  start_time: start_time.to_i,
                  write_key: api_key.write_key)

      expect(status).to eq(200)
      
      # reload the user due to update call
      incident.reload

      json = JSON.parse(response_body)

      incident_json = json["data"]

      expect(incident_json["description"]).to eq(description)
      expect(incident_json["location"]).to eq(location)
      expect(incident_json["reactions_list"]).to eq(incident.reactions_list)
      expect(incident_json["latitude"]).not_to be_nil
      expect(incident_json["longitude"]).not_to be_nil
      expect(incident_json["rating"]).to eq(rating)
      expect(incident_json["start_time"]).not_to be_nil

      expect(incident_json["created_at"]).not_to be_nil
      expect(incident_json["updated_at"]).not_to be_nil
    end
  end
end