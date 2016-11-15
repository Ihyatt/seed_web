class Attachment < ApplicationRecord
  # Assocations
  belongs_to :incident

  # Validations
  validates :incident, :presence => true
end
