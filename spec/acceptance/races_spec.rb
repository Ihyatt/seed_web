require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Races" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  
  get "/api/v1/races" do
    parameter :page, "Page Number"

    example "Get All Races" do
      Race.seed
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      races = json["data"]
      expect(races.count).to eq(3)

      race = Race.first

      race_json = races[0]
      expect(race_json["id"]).to eq(race.id)
      expect(race_json["name"]).to eq(race.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(Race.all.count)

    end
  end

end