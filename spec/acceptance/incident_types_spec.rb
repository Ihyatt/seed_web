require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "IncidentTypes" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  let!(:incident_type) { FactoryGirl.create(:incident_type) }
  
  get "/api/v1/incident_types" do
    parameter :page, "Page Number"

    example "Get All Incident Types" do
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      
      incident_types = json["data"]
      expect(incident_types.count).to eq(IncidentType.all.count)

      incident_type = IncidentType.first

      incident_type_json = incident_types[0]
      expect(incident_type_json["id"]).to eq(incident_type.id)
      expect(incident_type_json["name"]).to eq(incident_type.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(IncidentType.all.count)

    end
  end

end