class AddIncidentTypeToIncident < ActiveRecord::Migration[5.0]
  def change
    add_reference :incidents, :incident_type, foreign_key: true
  end
end
