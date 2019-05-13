class SearchResultsFacade
  def initialize(zipcode)
    @location = zipcode
  end

  def total_results
    get_json('/api/alt-fuel-stations/v1/nearest')[:total_results]
  end

  def nearest_stations
    all_data = get_json('/api/alt-fuel-stations/v1/nearest')[:fuel_stations].map do |station_data|
      DataParse::Station.new(station_data)
    end
    sorted = all_data.sort_by { |station| station.distance_from_location }
    sorted.take(15)
  end

  private

    def conn
      Faraday.new('https://developer.nrel.gov') do |f|
        f.params['format'] = 'json'
        f.params['api_key'] = ENV['nrel_api_key']
        f.params['location'] = @location
        f.params['status'] = 'E'
        f.adapter Faraday.default_adapter
      end
    end

    def get_json(url)
      @_response ||= conn.get do |f|
        f.url url
        f.params['fuel_type'] = 'ELEC,LPG'
        f.params['access'] = 'public'
      end
      JSON.parse(@_response.body, symbolize_names: true)
    end
end
