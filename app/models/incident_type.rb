class IncidentType < ApplicationRecord
  # Scopes
  scope :by_position, -> { order('position ASC') }

  # Associations
  has_many :incidents, inverse_of: :incident_type

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
