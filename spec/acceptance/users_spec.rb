require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  let(:user) { FactoryGirl.create(:user)}
  get "/api/v1/users" do
    example "Get All Users" do
      user
      do_request

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      users = json["data"]
      expect(users.count).to eq(1)

      user_json = users[0]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil

      #json.should == ""
    end
  end

  get "/api/v1/users/:id" do
    parameter :id, "User ID", required: true

    example "Get A User" do
      do_request(id: user.id)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      #json.should == ""

      user_json = json["data"]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil
    end
  end
end