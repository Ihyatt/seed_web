class IncidentSerializer < BaseSerializer
  attributes  :id, 
              :slug, 
              :user_id, 
              :incident_type_id,
              :description, 
              :start_time, 
              :location, 
              :reactions_list, 
              :latitude, 
              :longitude, 
              :rating, 
              :completed,
              :metadata,
              :created_at, 
              :updated_at

  has_one :user
  has_many :attachments
  has_many :officers

  def start_time
    object.start_time.utc.iso8601 if object.start_time
  end
end
