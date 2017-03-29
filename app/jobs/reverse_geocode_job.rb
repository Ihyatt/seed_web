class ReverseGeocodeJob < ApplicationJob
  queue_as :default

  def perform(incident_id)
    incident = Incident.find(incident_id)
    GeoService.reverse_geocode_incident(incident)
  end
end