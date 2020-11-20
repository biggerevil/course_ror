# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :initial_station, :end_station, :intermediate_stations

  def initialize(initial_station, end_station)
    @initial_station = initial_station
    @end_station = end_station
    @intermediate_stations = []
    register_instance
  end

  def add_station(station)
    @intermediate_stations << station
  end

  def delete_station(station)
    @intermediate_stations.delete(station)
  end

  def all_stations
    [initial_station, *intermediate_stations, end_station]
  end
end
