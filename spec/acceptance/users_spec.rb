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

      pagination = json["meta"]["pagination"]
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

    example "Get A User With Invalid Write Key" do
      do_request(id: 1234, write_key: "foo")
      json = JSON.parse(response_body)
      
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(403)
      expect(json["errors"][0]["message"]).to eq("Invalid Write Key")
    end
  end

  post "/api/v1/users" do
    parameter :email, "User Email", required: true
    parameter :password, "User Password", required: true

    example "Create A User" do
      email = FactoryGirl.generate(:email)
      password = "testtest"
      do_request(email: email, password: password, write_key: api_key.write_key)

      expect(status).to eq(200)
      
      # get the newly created user
      user = User.last

      json = JSON.parse(response_body)
      #json.should == ""

      user_json = json["data"]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil
    end

    example "Create A User with Missing Password Error" do
      email = FactoryGirl.generate(:email)
      password = nil
      do_request(email: email, password: password, write_key: api_key.write_key)

      expect(status).to eq(400)
      
      json = JSON.parse(response_body)
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(400)
      expect(json["errors"][0]["message"]).to eq("Password can't be blank")
      expect(json["errors"][0]["field"]).to eq("password")
    end

    example "Create A User with Missing Email Error" do
      email = nil
      password = "testtest"
      do_request(email: email, password: password, write_key: api_key.write_key)

      expect(status).to eq(400)
      
      json = JSON.parse(response_body)
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(400)
      expect(json["errors"][0]["message"]).to eq("Email can't be blank")
      expect(json["errors"][0]["field"]).to eq("email")
    end

    example "Create A User with Existing Email Error" do
      email = user.email
      password = "testtest"
      do_request(email: email, password: password, write_key: api_key.write_key)

      expect(status).to eq(400)
      
      json = JSON.parse(response_body)
      expect(json["success"]).to eq(false)
      expect(json["status"]).to eq(400)
      expect(json["errors"][0]["message"]).to eq("Email has already been taken")
      expect(json["errors"][0]["field"]).to eq("email")
    end
  end

  put "/api/v1/users/:id.json" do
    parameter :id, "User ID", required: true
    parameter :email, "New Email"
    parameter :password, "New Password"
    parameter :first_name, "First Name"
    parameter :last_name, "Last Name"
    parameter :race_id, "Race ID"
    parameter :gender_id, "Gender ID"
    parameter :birthday, "Birthday in Epoch Time (seconds since 1970)"

    example "Update A User" do
      Race.seed
      Gender.seed
      email = FactoryGirl.generate(:email)
      birthday = DateTime.now
      do_request(id: user.id, 
                  email: email, 
                  first_name: "Ketan", 
                  last_name: "Foo", 
                  write_key: api_key.write_key, 
                  race_id: Race.first.id, 
                  gender_id: Gender.first.id, 
                  birthday: birthday.to_i)

      expect(status).to eq(200)
      
      # reload the user due to update call
      user.reload
      expect(user.unconfirmed_email).to eq(email)
      expect(user.first_name).to eq("Ketan")

      json = JSON.parse(response_body)
      puts json
      user_json = json["data"]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["race_id"]).to eq(Race.first.id)
      expect(user_json["gender_id"]).to eq(Gender.first.id)
      expect(user_json["birthday"]).not_to be_nil
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil
    end
  end

  post "/api/v1/users/generate" do
    parameter :facebook_id, "Unique Facebook ID", required: true

    example "Generate A User From Facebook ID" do
      facebook_id = FactoryGirl.generate(:bitcoin_address)
      do_request(facebook_id: facebook_id)

      expect(status).to eq(200)
      
      json = JSON.parse(response_body)
      #json.should == ""

      # get the newly created user
      user = User.last

      user_json = json["data"]
      expect(user_json["id"]).to eq(user.id)
      expect(user_json["uid"]).to eq(user.uid)
      expect(user_json["facebook_id"]).to eq(facebook_id)
      expect(user_json["created_at"]).not_to be_nil
      expect(user_json["updated_at"]).not_to be_nil
    end
  end
end