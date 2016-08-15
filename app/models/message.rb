class Message < ApplicationRecord
  # Scopes
  scope :by_recent, -> {order('created_at ASC')}

  # Associations
  belongs_to :conversation
  belongs_to :user

  # Validations
  validates :conversation, :presence => true
  validates :user, :presence => true
  validates :text, :presence => true
  validates :platform, :presence => true

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
