class User < ApplicationRecord
  # Associations
  has_many :messages, dependent: :destroy, inverse_of: :user
  has_many :api_keys, dependent: :destroy, inverse_of: :user
  belongs_to :race
  belongs_to :gender

  # Extensions
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Validations
  validates :email, :uniqueness => true, :presence => true
  validates :uid, :uniqueness => true, :presence => true

  # Callbacks
  after_initialize :setup, on: :create
  
  def setup
    ensure_uid
    set_default_role
  end

  def set_default_role
    add_role :normal
  end

  def ensure_uid
    if uid.blank?
      self.uid = loop do
        uid = SecureRandom.hex(4)
        break uid unless User.where(uid: uid).exists?
      end
    end
  end

  def is_admin
    self.has_role?(:admin)
  end

  def display_name
    return first_name if first_name.present?
    return email
  end
  
  # Send Devise notifications through ActiveJob deliver_later
  # https://github.com/plataformatec/devise#activejob-integration
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
