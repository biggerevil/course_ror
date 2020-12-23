# frozen_string_literal: true

require_relative 'vendor'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Vendor
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  attr_reader :speed, :route, :current_station, :type, :cars, :number

  validate :number, :presence
  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  @@all_created_trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
    self.class.validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
    validate!
    @@all_created_trains[number] = self
    register_instance
  end

  def self.find(required_number)
    @@all_created_trains.select { |train_number| train_number == required_number }.first
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

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def for_each(&block)
    @cars.each { |car| block.call(car) } if block_given?
  end
end
