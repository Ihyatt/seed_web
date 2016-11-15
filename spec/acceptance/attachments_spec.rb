require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Attachments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:api_key) { FactoryGirl.create(:api_key, user: user) }
  let!(:incident) { FactoryGirl.create(:incident, user: user) }
  
  post "/api/v1/attachments" do
    parameter :attachment_id, "Incident ID", required: true
    parameter :asset, "Asset upload"
    
    example "Create An Attachment" do

      do_request( incident_id: incident.id,
                  asset: File.open( Rails.root + 'spec/support/fixtures/image.png'),
                  write_key: api_key.write_key)

      expect(status).to eq(200)
      
      # get the newly created attachment
      attachment = Attachment.last

      json = JSON.parse(response_body)
      #json.should == ""

      attachment_json = json["data"]
    
      expect(attachment_json["id"]).to eq(attachment.id)
      expect(attachment_json["incident_id"]).to eq(incident.id)
      expect(attachment_json["asset_original_url"]).not_to be_nil
      expect(attachment_json["created_at"]).not_to be_nil
      expect(attachment_json["updated_at"]).not_to be_nil
    end
  end

  
end