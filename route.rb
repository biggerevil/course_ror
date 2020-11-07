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
    print initial_station.name
    print ' '
    @intermediate_stations.each do |station|
      print station.name
      print ' '
    end
    puts end_station.name
  end
end
