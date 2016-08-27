class Race < ApplicationRecord
  # Scopes
  scope :by_position, -> { order('position ASC') }
  
  # Associations
  has_many :users, inverse_of: :race
  

  validates :name, presence: true

  def self.seed
    Race.where(name: "White").first_or_create
    Race.where(name: "Black").first_or_create
    Race.where(name: "Asian").first_or_create
  end
end
