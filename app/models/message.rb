class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  # Validations
  validates :conversation, :presence => true
  validates :user, :presence => true
  validates :text, :presence => true
end
