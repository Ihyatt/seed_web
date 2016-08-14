require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  let(:user) { FactoryGirl.create(:user) }
  let(:api_key) { FactoryGirl.create(:api_key, user: user) }
  
  get "/api/v1/users" do
    parameter :page, "Page of users"

    example "Get All Users" do
      user
      do_request(write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      users = json["data"]
      expect(users.count).to eq(1)

      user_json = users[0]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil

      pagination = json["pagination"]
      expect(pagination["page"]).to eq(1)
      expect(pagination["total_pages"]).to eq(1)
      expect(pagination["count"]).to eq(User.all.size)

    end
  end

  get "/api/v1/users/:id" do
    parameter :id, "User ID", required: true

    example "Get A User" do
      do_request(id: user.id, write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      #json.should == ""

      user_json = json["data"]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil
    end

    example "Get A User With Error" do
      do_request(id: 1234, write_key: api_key.write_key)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(404)
      expect(json["errors"][0]["message"]).to eq("Couldn't find User with 'id'=1234")
    end
  end
end