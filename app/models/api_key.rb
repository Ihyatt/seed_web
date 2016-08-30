class APIKey < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :user, :presence => true
  validates :read_key, :uniqueness => true, :presence => true
  validates :write_key, :uniqueness => true, :presence => true

  # Callbacks
  after_initialize :ensure_read_key, on: :create
  after_initialize :ensure_write_key, on: :create
  

  def ensure_read_key
    if read_key.blank?
      self.read_key = loop do
        read_key = SecureRandom.hex(16)
        break read_key unless APIKey.where(read_key: read_key).exists?
      end
    end
  end

  def ensure_write_key
    if write_key.blank?
      self.write_key = loop do
        write_key = SecureRandom.hex(16)
        break write_key unless APIKey.where(write_key: write_key).exists?
      end
    end
  end
end
