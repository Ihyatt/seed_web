class Officer < ApplicationRecord
  belongs_to :incident
  belongs_to :race
  belongs_to :gender

  # Validations
  validates :incident, :presence => true
end
