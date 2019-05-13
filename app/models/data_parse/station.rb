class DataParse::Station
  attr_reader :name,
              :address,
              :fuel_types,
              :distance_from_location,
              :availability

  def initialize(station_data)
    require "pry"; binding.pry
    @name = station_data[:station_name]
    @address = station_data[:street_address] + ', ' + station_data[:city]  + ', ' + station_data[:state]  + ' ' + station_data[:zip]
    @fuel_types = station_data[:]
  end
end
