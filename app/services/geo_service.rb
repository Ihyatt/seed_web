class GeoService
  class << self
    def reverse_geocode(lat, lon)
      results = Geocoder.search([lat, lon])
      results.first
    end

    def cache_result(result)
      # WARNING: This code is prone to race conditions.
      # To ensure data integrity when this function is called in parallel,
      # make sure that there is a unique index on Place
      #
      # WARNING: This code isn't properly indexed, so it's going to be slow
      # Need to add indicies for the select query

      country = state = county = city = neighborhood = nil
      Place.transaction do
        country = Place.find_or_create_by!(
            name: result.country,
            slug: result.country.downcase.split(" ").join("-"),
            short: result.country_code,
            level: Place::COUNTRY,
            parent_id: nil,
            latitude: nil,
            longitude: nil,
        )

        state = Place.find_or_create_by!(
            name: result.state,
            slug: result.state.downcase.split(" ").join("-"),
            short: result.state_code,
            level: Place::STATE,
            parent_id: country.id,
            latitude: nil,
            longitude: nil,
        )

        county = Place.find_or_create_by!(
            name: result.sub_state,
            slug: result.sub_state.downcase.split(" ").join("-"),
            short: nil,
            level: Place::COUNTY,
            parent_id: state.id,
            latitude: nil,
            longitude: nil,
        )

        city = Place.find_or_create_by!(
            name: result.city,
            slug: result.city.downcase.split(" ").join("-"),
            short: nil,
            level: Place::CITY,
            parent_id: county.id,
            latitude: nil,
            longitude: nil,
        )

        neighborhood = Place.find_or_create_by!(
            name: result.neighborhood,
            slug: result.neighborhood.downcase.split(" ").join("-"),
            short: nil,
            level: Place::NEIGHBORHOOD,
            parent_id: city.id,
            latitude: nil,
            longitude: nil,
        )
      end

      {
          country: country,
          state: state,
          county: county,
          city: city,
          neighborhood: neighborhood,
      }
    end
  end
end