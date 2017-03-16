class PlaceSerializer < BaseSerializer
  attributes  :id, 
              :name, 
              :slug, 
              :short,
              :level, 
              :parent_id,
              :latitude, 
              :longitude, 
              :created_at, 
              :updated_at

  
end
