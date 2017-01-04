class Incident < ApplicationRecord
  # Extensions
  acts_as_taggable_array_on :reactions

  extend FriendlyId
  friendly_id :slug
  geocoded_by :location              # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates   

  # Scopes
  scope :completed, ->  { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :by_user, ->    (user) { where(user: user) }
  
  # Associations
  belongs_to :user
  belongs_to :incident_type
  has_many :attachments, dependent: :destroy, inverse_of: :incident
  has_many :officers, dependent: :destroy, inverse_of: :incident

  # Validations
  validates :slug, :uniqueness => true, :presence => true
  validates :user, :presence => true
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

  # Callbacks
  after_initialize :ensure_slug, on: :create
  validate :reactions_exist
  
  def ensure_slug
    if slug.blank?
      self.slug = loop do
        slug = SecureRandom.urlsafe_base64(6).tr('1+/=lIO0_-', 'pqrsxyz')
        break slug unless Incident.where(slug: slug).exists?
      end
    end
  end

  def reactions_list=(string)
    self.reactions = string.split(",").map!(&:strip)
  end

  def reactions_list
    self.reactions.join(",")
  end

  def reactions_exist
    reactions.each do |name|
      if Reaction.where('name ilike ?', name).empty?
        errors.add(:reactions, "#{name} isn't a valid reaction")
      end
    end
  end

  def start_time=(value)
    self.write_attribute(:start_time, Time.at(value.to_i))
  end

  def self.search_by(user: nil, completed: nil)
    scope = Incident.all

    if user
      scope = scope.by_user(user)
    end

    unless completed.nil?
      if completed == true
        scope = scope.completed
      else
        scope = scope.incomplete
      end
    end

    return scope
  end

  rails_admin do      
    weight -100

    list do
      scopes [nil, :completed, :incomplete]
    end
  end

end