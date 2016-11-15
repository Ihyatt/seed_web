class AttachmentSerializer < BaseSerializer
  attributes  :id,
              :incident_id,
              :asset_original_url,
              :asset_name, 
              :asset_width, 
              :asset_height, 
              :created_at, 
              :updated_at


  def asset_original_url
    object.asset.url if object.asset_stored?
  end
end
