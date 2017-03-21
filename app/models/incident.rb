class Incident < ApplicationRecord
  # Extensions
  acts_as_taggable_array_on :reactions
  acts_as_taggable_array_on :tags

  extend FriendlyId
  friendly_id :slug
  geocoded_by :location              # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  reverse_geocoded_by :latitude, :longitude 
  after_validation :reverse_geocode
  

  # Scopes
  scope :completed, ->        { where(completed: true) }
  scope :incomplete, ->       { where(completed: false) }
  scope :by_user, ->          (user) { where(user: user) }
  scope :by_incident_type, -> (incident_type) { where(incident_type: incident_type) }
  scope :between, ->          (start_date, end_date) { where("incidents.start_time BETWEEN ? and ?", start_date, end_date) }
  scope :with_any_rating, ->  (ratings) { where(rating: ratings.map(&:to_i)) }
  scope :with_coordinates, -> { where.not(latitude: nil, longitude: nil) }
  scope :without_address, ->  { where(address: nil)}
  
  # Associations
  belongs_to :user
  belongs_to :incident_type
  belongs_to :place
  has_many :attachments, dependent: :destroy, inverse_of: :incident
  has_many :officers, dependent: :destroy, inverse_of: :incident

  # Validations
  validates :slug, :uniqueness => true, :presence => true
  validates :user, :presence => true
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

  # Callbacks
  after_initialize :ensure_slug, on: :create
  validate :reactions_exist
  validate :tags_exist
  
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


  def tags_list=(string)
    self.tags = string.split(",").map!(&:strip)
  end

  def tags_list
    self.tags.join(",")
  end

  def tags_exist
    tags.each do |name|
      if Tag.where('name ilike ?', name).empty?
        errors.add(:tags, "#{name} isn't a valid tag")
      end
    end
  end

  def incident_type_name=(value)
    found_record = IncidentType.search_by_exact_name(value).first
    self.incident_type = found_record if found_record.present?
  end

  def start_time=(value)
    self.write_attribute(:start_time, Time.at(value.to_i))
  end

  def self.search_by( user_id: nil, completed: nil, 
                      reactions: nil, tags: nil, ratings: nil,
                      incident_type_id: nil, place_id: nil,
                      start_time: nil, end_time: nil
                      )

    scope = Incident.all

    if user_id
      scope = scope.by_user(User.find user_id)
    end

    if start_time || end_time
      end_time = start_time + 1.year if end_time.nil?
      scope = scope.between(start_time, end_time)
    end

    unless completed.nil?
      if completed == true
        scope = scope.completed
      else
        scope = scope.incomplete
      end
    end

    if reactions
      array = reactions.split(",").map!(&:strip)
      scope = scope.with_any_reactions(array)
    end

    if tags
      array = tags.split(",").map!(&:strip)
      scope = scope.with_any_tags(array)
    end

    if ratings
      array = ratings.split(",").map(&:strip)
      scope = scope.with_any_rating(array)
    end

    if incident_type_id
      incident_type = IncidentType.find(incident_type_id)
      scope = scope.by_incident_type(incident_type)
    end

    if place_id
      place = Place.find(place_id)
      scope = scope.where(place: place.self_and_descendants)
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