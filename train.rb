# frozen_string_literal: true

class Train
  attr_reader :speed, :route, :current_station, :type, :cars, :number

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
  end

  def add_car(car)
    cars.push(car) unless car.type != type
  end

  def remove_car
    cars.pop
  end

  def gain_speed
    @speed += 10
  end

  def lose_speed
    @speed = 0
  end

  def route=(route)
    @route = route
    @current_station = route.initial_station
    @current_station.add_train(self)
  end

  def move_forward
    # If current station is the last station of the route
    return unless next_station

    @current_station.remove_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_back
    # If current station is the first station of the route
    return unless previous_station

    @current_station.remove_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def previous_station
    all_stations = route.all_stations
    index_of_current_station = all_stations.index(@current_station)
    # If current station is the first station of the route
    return if index_of_current_station.zero?
    return unless index_of_current_station

    all_stations[index_of_current_station - 1]
  end

  def next_station
    all_stations = route.all_stations
    index_of_current_station = all_stations.index(@current_station)
    # If current station is the last station of the route
    return if index_of_current_station == (all_stations.length - 1)
    return unless index_of_current_station

    all_stations[index_of_current_station + 1]
  end
end
