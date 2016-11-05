class IncidentSerializer < ActiveModel::Serializer
  attributes  :id, 
              :slug, 
              :user_id, 
              :description, 
              :start_time, 
              :location, 
              :reactions_list, 
              :latitude, 
              :longitude, 
              :rating, 
              :completed,
              :created_at, 
              :updated_at

  has_one :user

  def start_time
    object.start_time.utc.iso8601 if object.start_time
  end
end
