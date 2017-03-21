class IncidentType < ApplicationRecord
  include Searchable
  # Scopes
  scope :by_position, -> { order('position ASC') }

  # Associations
  has_many :incidents, inverse_of: :incident_type

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.seed
    IncidentType.where(name: "got pulled over").first_or_create
    IncidentType.where(name: "called the police").first_or_create
    IncidentType.where(name: "got stopped on foot").first_or_create
    IncidentType.where(name: "witnessed police").first_or_create
    IncidentType.where(name: "other").first_or_create
  end
end
