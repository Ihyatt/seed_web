class OfficerSerializer < BaseSerializer
  attributes  :id,
              :incident_id,
              :race_id,
              :gender_id, 
              :name, 
              :badge_number,
              :description, 
              :created_at, 
              :updated_at

end
