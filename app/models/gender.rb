class Gender < ApplicationRecord
  include Searchable
  # Scopes
  scope :by_position, -> { order('position ASC') }
  
  # Associations
  has_many :users, inverse_of: :gender
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.seed
    Gender.where(name: "Male").first_or_create
    Gender.where(name: "Female").first_or_create
  end
end
