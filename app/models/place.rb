class Place < ApplicationRecord
  COUNTRY = "country"
  REGION = "region"
  DIVISION = "division"
  STATE = "state"
  CITY = "city"
  NEIGHBORHOOD = "neighborhood"

  VALID_LEVELS = [
    COUNTRY,
    REGION,
    DIVISION,
    STATE,
    CITY,
    NEIGHBORHOOD
  ]

  # Extensions
  extend FriendlyId
  friendly_id :name_and_short, :use => :slugged

  acts_as_tree order: "name"

  auto_strip_attributes :name, :squish => true
  auto_strip_attributes :short, :squish => true
  auto_strip_attributes :slug, :squish => true
  auto_strip_attributes :level, :squish => true

  # Validations
  validates_presence_of :name, :slug
  validates_uniqueness_of :name, scope: [:parent_id], case_sensitive: false
  validates_uniqueness_of :slug

  validates :level, presence: true, inclusion: { in: VALID_LEVELS, message: "%{value} is not a valid level" }


  def name_and_short
    return name if parent.nil?
    return "#{name}-#{parent.short}" if parent.short
    return "#{name}-#{parent.name}"
  end

  def self.import_countries
    csv_file = File.join(FastSeeder.seeds_path, 'countries.csv')
    countries = CSV.read(csv_file)
    countries.each do |data|
      country = Place.find_or_create_by(name: data[0], short: data[1].upcase, level: Place::COUNTRY)
    end
  end

  def self.import_regions
    self.import_countries

    csv_file = File.join(FastSeeder.seeds_path, 'regions.csv')
    regions = CSV.read(csv_file)
    regions.each do |data|
      country_code = data[1].upcase
      country = Place.where(short: country_code, level: Place::COUNTRY).first
      region = Place.find_or_create_by(name: data[0], level: Place::REGION, parent_id: country.id)
    end
  end

  def self.import_divisions
    self.import_regions

    csv_file = File.join(FastSeeder.seeds_path, 'divisions.csv')
    divisions = CSV.read(csv_file)
    divisions.each do |data|
      region_name = data[1]
      region = Place.where(name: region_name, level: Place::REGION).first
      division = Place.find_or_create_by(name: data[0], level: Place::DIVISION, parent_id: region.id)
    end
  end

  def self.import_states
    self.import_divisions

    csv_file = File.join(FastSeeder.seeds_path, 'states.csv')
    states = CSV.read(csv_file)
    states.each do |data|
      division_name = data[2]
      division = Place.where(name: division_name, level: Place::DIVISION).first
      state = Place.find_or_create_by(name: data[0], short: data[1].upcase, level: Place::STATE, parent_id: division.id)
    end
  end

  def self.import_cities
    self.import_states

    csv_file = File.join(FastSeeder.seeds_path, 'cities.csv')
    cities = CSV.read(csv_file)
    cities.each do |data|
      name = data[0]
      state_code = data[1]
      state = Place.where(short: state_code, level: Place::STATE).first
      if state
        city = Place.find_or_create_by(name: name, level: Place::CITY, parent_id: state.id)
      end
    end
  end
end
