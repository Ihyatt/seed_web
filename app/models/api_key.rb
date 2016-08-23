class APIKey < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :user, :presence => true
  validates :app_token, :uniqueness => true, :presence => true
  # validates :write_key, :uniqueness => true, :presence => true

  # Callbacks
  after_initialize :ensure_app_token, on: :create
  # after_initialize :ensure_write_key, on: :create
  
  def ensure_app_token
    if app_token.blank?
      self.app_token = loop do
        app_token = SecureRandom.hex(16)
        break app_token unless APIKey.where(app_token: app_token).exists?
      end
    end
  end 