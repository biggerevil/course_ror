class Route
  attr_reader :initial_station, :end_station, :intermediate_stations

  def initialize(initial_station, end_station)
    @initial_station = initial_station
    @end_station = end_station
    @intermediate_stations = []
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    @intermediate_stations.delete(station)
  end

  def all_stations
    all_stations_array = []
    all_stations_array << initial_station
    intermediate_stations.each do |station|
      all_stations_array << station
    end
    all_stations_array << end_station
    all_stations_array
  end
end
