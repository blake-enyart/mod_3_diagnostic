class SearchResultsFacade
  def initialize(zipcode)
    @location = zipcode
  end

  def total_results

  end

  def nearest_stations
    # require "pry"; binding.pry
    conn = Faraday.new('https://developer.nrel.gov/api/alt-fuel-stations/v1') do |f|
      f.params['format'] = 'json'
      f.params['api_key'] = ENV['nrel_api_key']
      f.adapter Faraday.default_adapter
    end

    response = conn.get('/nearest') do |f|
      f.params['location'] = @location
      f.params['fuel_type'] = ['ELEC','LPG']
      f.params['status'] = 'E'
    end
    require "pry"; binding.pry

    data = JSON.parse(response.body, symbolize_names: true)

  end
end
