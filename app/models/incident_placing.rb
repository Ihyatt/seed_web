class IncidentPlacing < ApplicationRecord
  validates_presence_of :incident_id, :place_id
end