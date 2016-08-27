class Reaction < ApplicationRecord
  # Scopes
  scope :by_position, -> { order('position ASC') }
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
