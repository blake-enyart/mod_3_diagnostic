class SearchResultsFacade
  def initialize(zipcode)
    @location = zipcode
  end

  def total_results

  end

  def nearest_stations
    conn = Faraday.new('https://developer.nrel.gov') do |f|
      f.params['format'] = 'json'
      f.params['api_key'] = ENV['nrel_api_key']
      f.params['location'] = @location
      f.params['status'] = 'E'
      f.adapter Faraday.default_adapter
    end

    response = conn.get do |f|
      f.url 'api/alt-fuel-stations/v1/nearest'
      f.params['fuel_type'] = 'ELEC,LPG'
      f.params['access'] = 'public'
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
