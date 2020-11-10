# frozen_string_literal: true

class Train
  attr_reader :wagons_amount, :speed, :route, :current_station, :type

  def initialize(number, type, wagons_amount)
    @number = number
    @type = type
    @wagons_amount = wagons_amount
    @speed = 0
  end

  def add_wagon
    @wagons_amount += 1
  end

  def remove_wagon
    @wagons_amount -= 1
  end

  def gain_speed
    @speed += 10
  end

  def lose_speed
    @speed = 0
  end

  def set_route(route)
    @route = route
    @current_station = route.initial_station
    @current_station.add_train(self)
  end

  def move_forward
    # If current station is the last station of the route
    return unless get_next_station

    @current_station.remove_train(self)
    @current_station = get_next_station
    @current_station.add_train(self)
  end

  def move_back
    # If current station is the first station of the route
    return unless get_previous_station

    @current_station.remove_train(self)
    @current_station = get_previous_station
    @current_station.add_train(self)
  end

  def get_previous_station
    all_stations = route.all_stations
    index_of_current_station = all_stations.index(@current_station)
    # If current station is the first station of the route
    return if index_of_current_station.zero?
    return unless index_of_current_station

    all_stations[index_of_current_station - 1]
  end

  def get_next_station
    all_stations = route.all_stations
    index_of_current_station = all_stations.index(@current_station)
    # If current station is the last station of the route
    return if index_of_current_station == (all_stations.length - 1)
    return unless index_of_current_station

    all_stations[index_of_current_station + 1]
  end
end
