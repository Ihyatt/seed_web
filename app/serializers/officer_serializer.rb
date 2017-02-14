class OfficerSerializer < BaseSerializer
  attributes  :id,
              :incident_id,
              :race_id,
              :gender_id, 
              :name, 
              :badge_number,
              :description,
              :age_estimate,
              :created_at, 
              :updated_at

end
