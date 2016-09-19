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
    end

    it "should import states" do
      Place.import_states

      usa = Place.where(short:'US', level: Place::COUNTRY).first
      expect(usa).not_to be_nil

      states = Place.where(level: Place::STATE)
      expect(states.count).to be > 1
      
      california = Place.where(name:'California', level: Place::STATE).first
      expect(california.short).to eq("CA")
      expect(california.parent).to eq(usa)
    end

    it "should import cities" do
      Place.import_cities

      la = Place.where(name:'Los Angeles').first
      expect(la).not_to be_nil
      expect(la.parent.name).to eq("California")
      

      sf = Place.where(name:'San Francisco').first
      sf.should_not be_nil
      expect(sf.parent.name).to eq("California")
    end
  end
end
