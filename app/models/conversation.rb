class Conversation < ApplicationRecord
  extend FriendlyId
  friendly_id :slug

  # Validations
  validates :slug, :uniqueness => true, :presence => true

  # Callbacks
  after_initialize :ensure_slug, on: :create
  

  def ensure_slug
    if slug.blank?
      self.slug = loop do
        slug = SecureRandom.hex(8)
        break slug unless Conversation.where(slug: slug).exists?
      end
    end
  end

end
