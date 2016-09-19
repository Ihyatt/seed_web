require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) { FactoryGirl.build(:place) }
  
  subject { place }

  describe "associations" do
    it { should belong_to(:parent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    # it { should validate_presence_of(:slug) }
    # it { should validate_uniqueness_of(:slug) }
  end

  describe "slugs" do
    it "should create slug based on name and state code" do
      california = FactoryGirl.create(:place, name: 'California', level: Place::STATE, short: 'CA')
      place.parent = california
      place.name = "San Francisco"
      place.save

      expect(place.slug).to eq("san-francisco-ca")
    end
  end

  describe "imports" do
    it "should import countries" do
      Place.import_countries

      countries = Place.where(level: Place::COUNTRY)
      usa = Place.where(short:'US', level: Place::COUNTRY).first

      expect(countries.count).to eq(1)
      expect(usa).not_to be_nil
      expect(usa.slug).to eq("united-states")
    end

    it "should import regions" do
      Place.import_regions

      usa = Place.where(short:'US', level: Place::COUNTRY).first
      regions = Place.where(level: Place::REGION)
      west = Place.where(name:'West', level: Place::REGION).first
      
      expect(regions.count).to eq(4)

      expect(west).not_to be_nil
      expect(west.parent).to eq(usa)
      expect(west.slug).to eq("west-us")
    end

    it "should import divisions",focus: true do
      Place.import_divisions

      divisions = Place.where(level: Place::DIVISION)
      northeast = Place.where(name:'Northeast', level: Place::REGION).first
      new_england = Place.where(name:'New England', level: Place::DIVISION).first
      
      expect(divisions.count).to eq(9)
      
      expect(new_england).not_to be_nil
      expect(new_england.parent).to eq(northeast)
      expect(new_england.slug).to eq("new-england-northeast")
    end

    it "should import states" do
      Place.import_states

      pacific = Place.where(name:'Pacific', level: Place::DIVISION).first
      expect(pacific).not_to be_nil

      states = Place.where(level: Place::STATE)
      expect(states.count).to eq(51)
      
      california = Place.where(name:'California', level: Place::STATE).first
      expect(california.short).to eq("CA")
      expect(california.parent).to eq(pacific)
      expect(california.slug).to eq("california-pacific")
    end

    it "should import cities" do
      Place.import_cities

      la = Place.where(name:'Los Angeles').first

      expect(la).not_to be_nil
      expect(la.slug).to eq("los-angeles-ca")
      expect(la.parent.name).to eq("California")
      
      sf = Place.where(name:'San Francisco').first

      expect(sf).not_to be_nil
      expect(sf.slug).to eq("san-francisco-ca")
      expect(sf.parent.name).to eq("California")
    end
  end
end
