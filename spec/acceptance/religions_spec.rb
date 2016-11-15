require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Religions" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  
  get "/api/v1/religions" do
    parameter :page, "Page Number"

    example "Get All Religions" do
      Religion.seed
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      religions = json["data"]
      expect(religions.count).to eq(Religion.all.count)

      religion = Religion.first

      religion_json = religions[0]
      expect(religion_json["id"]).to eq(religion.id)
      expect(religion_json["name"]).to eq(religion.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(Religion.all.count)

    end
  end

end