require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Genders" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  
  get "/api/v1/genders" do
    parameter :page, "Page Number"

    example "Get All Genders" do
      Gender.seed
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      genders = json["data"]
      expect(genders.count).to eq(Gender.all.count)

      gender = Gender.first

      gender_json = genders[0]
      expect(gender_json["id"]).to eq(gender.id)
      expect(gender_json["name"]).to eq(gender.name)
      
      pagination = json["meta"]["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(Gender.all.count)

    end
  end

end