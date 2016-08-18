class Incident < ApplicationRecord
  # Extensions
  extend FriendlyId
  friendly_id :slug

  # Associations
  belongs_to :user

  # Validations
  validates :slug, :uniqueness => true, :presence => true
  validates :user, :presence => true

  # Callbacks
  after_initialize :ensure_slug, on: :create
  
  def ensure_slug
    if slug.blank?
      self.slug = loop do
        slug = SecureRandom.urlsafe_base64(6).tr('1+/=lIO0_-', 'pqrsxyz')
        break slug unless Incident.where(slug: slug).exists?
      end
    end
  end
end
