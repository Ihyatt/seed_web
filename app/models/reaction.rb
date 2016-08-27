class Reaction < ApplicationRecord
  # Scopes
  scope :by_position, -> { order('position ASC') }
  scope :positive, ->    { where(positive: true) }
  scope :negative, ->    { where(positive: false) }
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
