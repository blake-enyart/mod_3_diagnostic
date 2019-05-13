class SearchResultsFacade
  def initialize(zipcode)
    @location = zipcode
  end

  def total_results

  end

  def nearest_stations
    conn = Faraday.new(url: 'https://api/alt-fuel-stations/v1') do |f|
      f.params['format'] = 'json'
      f.params['api_key'] = ENV['nrel_api_key']
      f.params['location'] = @location
      f.params['fuel_type'] = ['ELEC', 'LPG']
      f.params['status'] = 'E'
      f.adapter  Faraday.default_adapter
    end

    response = conn.get
    require "pry"; binding.pry
  end
end
