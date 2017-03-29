require "rails_helper"

describe GeoService do
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.set_default_stub(
      [
          {
              latitude: 37.7434243,
              longitude: -122.4285729,
              address: '385 29th St, San Francisco, CA 94131, USA',
              formatted_address: '385 29th St, San Francisco, CA 94131, USA',
              state: 'California',
              state_code: 'CA',
              country: 'United States',
              country_code: 'US',
              city: 'San Francisco',
              street_number: '385',
              neighborhood: 'Noe Valley',
              sub_state: 'San Francisco County',
              postal_code: '94131',
          }
      ]
  )

  let(:lat) { 37.743424 }
  let(:lon) { -122.428573 }

  describe "reverse geocoding" do
    it "reverse geocodes a lat/lon" do
      result = GeoService.reverse_geocode(lat, lon)
      expect(result.address).to eq "385 29th St, San Francisco, CA 94131, USA"
      expect(result.state).to eq "California"
      expect(result.city).to eq "San Francisco"
      expect(result.neighborhood).to eq "Noe Valley"
    end
  end

  describe "persisting places" do
    let(:result) { GeoService.reverse_geocode(lat, lon) }

    it "saves new places" do
      expect(Place.count).to eq 0
      GeoService.cache_result(result)
      expect(Place.count).to eq 5
    end

    it "doesn't save duplicate places" do
      usa = Place.create(
          name: "United States",
          slug: "united-states",
          short: "US",
          level: Place::COUNTRY,
      )

      expect(Place.count).to eq 1
      ps = GeoService.cache_result(result)
      expect(Place.count).to eq 5

      expect(ps[:state].parent_id).to eq usa.id
    end
  end

  describe "reverse geocoding an incident" do
    let(:incident) { FactoryGirl.create(:incident, latitude: lat, longitude: lon) }
    subject { GeoService.reverse_geocode_incident(incident) }

    it "saves the places" do
      expect(Place.count).to eq 0
      subject
      expect(Place.count).to eq 5
    end

    it "associates an incident with a location" do
      expect(IncidentPlacing.count).to eq 0
      subject
      expect(IncidentPlacing.count).to eq 5
    end
  end
end