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
              :created_at, 
              :updated_at

  has_one :user
end
