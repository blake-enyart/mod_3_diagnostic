class SearchResultsFacade
  def initialize(zipcode)
    @location = zipcode
  end

  def total_results
    nearest_stations.count
  end

  def nearest_stations
    get_json('/api/alt-fuel-stations/v1/nearest').map do |station_data|
      DataParse::Station.new(station_data)
    end
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
      response = conn.get do |f|
        f.url url
        f.params['fuel_type'] = 'ELEC,LPG'
        f.params['access'] = 'public'
      end
      a = JSON.parse(response.body, symbolize_names: true)[:fuel_stations]
      require "pry"; binding.pry
    end
end
