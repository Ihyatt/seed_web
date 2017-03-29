class IncidentQuery < ApplicationRecord

  def incidents
    Incident.search_by(completed: completed, reactions: reactions, tags: tags, ratings: ratings,
                      incident_type_id: incident_type_id, place_id: place_id,
                      start_time: start_time, end_time: end_time)
  end

  def self.search_by( completed: nil, reactions: nil, tags: nil, ratings: nil,
                      incident_type_id: nil, place_id: nil,
                      start_time: nil, end_time: nil
                      )

    reactions = self.normalize_tag_input(reactions) if reactions.present?
    tags      = self.normalize_tag_input(tags) if tags.present?
    ratings   = self.normalize_tag_input(ratings) if ratings.present?
    
    incident_query = IncidentQuery.find_or_create_by(completed: completed, reactions: reactions, tags: tags, ratings: ratings,
                      incident_type_id: incident_type_id, place_id: place_id,
                      start_time: start_time, end_time: end_time)

    incidents = incident_query.incidents

    incident_query.update_attributes(
        total_count: incidents.count, 
        negative_count: incidents.negative.count,
        positive_count: incidents.positive.count
      )
    return incident_query
  end

  def self.normalize_tag_input(input)
    input.split(",").map(&:strip).join(", ") if input.present?
  end
end
