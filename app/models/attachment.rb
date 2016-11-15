class Attachment < ApplicationRecord
  # Extensions
  has_attached_file :asset

  # Associations
  belongs_to :incident

  # Validations
  validates :incident, :presence => true
  validates :asset, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :asset, less_than: 5.megabytes
  # Explicitly do not validate
  do_not_validate_attachment_file_type :asset
end
