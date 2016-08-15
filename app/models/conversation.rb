class Conversation < ApplicationRecord
  # Associations
  has_many :messages, dependent: :destroy, inverse_of: :conversation
  has_many :users, -> { distinct }, through: :messages
  belongs_to :customer, class_name: 'User'

  # Extensions
  extend FriendlyId
  friendly_id :slug

  # Validations
  validates :slug, :uniqueness => true, :presence => true
  validates :customer, :presence => true
  validates :customer_id, :uniqueness => true

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

  def self.create_for_customer(customer)
    conversation = self.where(customer: customer).first_or_create
  end
end
