class IncidentSerializer < ActiveModel::Serializer
  attributes :id, :slug, :description, :start_time, :location, :latitude, :longitude
  has_one :user
end
