class Religion < ApplicationRecord
  # Extensions
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Scopes
  scope :by_position, -> { order('position ASC') }
  
  # Associations
  has_many :users, inverse_of: :religion
  

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :slug, presence: true, uniqueness: {case_sensitive: false}

  def self.seed
    Religion.where(name: "Other").first_or_create
    Religion.where(name: "Agnostic").first_or_create
    Religion.where(name: "Atheist").first_or_create
    Religion.where(name: "Christian").first_or_create
    Religion.where(name: "Jewish").first_or_create
    Religion.where(name: "Catholic").first_or_create
    Religion.where(name: "Muslim").first_or_create
    Religion.where(name: "Hindu").first_or_create
    Religion.where(name: "Buddhist").first_or_create
    Religion.where(name: "Sikh").first_or_create
  end
end
