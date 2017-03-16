require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Places" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  before(:each) do
    Place.import_cities
  end
  
  get "/api/v1/places" do
    parameter :page, "Page Number"
    parameter :name, "Search place by name"
    parameter :level, "Search place by level"

    example "Get All Places" do
      
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      places = json["data"]
      expect(places.count).to eq(25)

      place = Place.first
      place_json = places[0]
      
      expect(place_json["id"]).to eq(place.id)
      expect(place_json["name"]).to eq(place.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(5)
      expect(pagination["count"]).to eq(Place.all.count)

    end

    example "Search place by name" do
      do_request(write_key: api_key.write_key, name: "San Francisco")

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      places = json["data"]

      expect(places.count).to eq(1)

      place = Place.where(slug: "san-francisco-ca").first
      place_json = places[0]

      expect(place_json["id"]).to eq(place.id)
      expect(place_json["name"]).to eq(place.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(1)
    end

    example "Search place by level" do
      do_request(write_key: api_key.write_key, level: Place::STATE)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      places = json["data"]

      expect(places.count).to eq(25)

      place = Place.where(level: Place::STATE).first
      place_json = places[0]

      expect(place_json["id"]).to eq(place.id)
      expect(place_json["name"]).to eq(place.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(3)
      expect(pagination["count"]).to eq(51)
    end


  end

end