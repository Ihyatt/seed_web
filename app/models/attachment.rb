class Attachment < ApplicationRecord
  # Extensions
  dragonfly_accessor :asset
  
  # Associations
  belongs_to :incident

  # Validations
  validates :incident, :presence => true
  validates_presence_of :asset
  validates_size_of :asset, maximum: 5.megabytes
end
