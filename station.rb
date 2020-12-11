# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains_on_station, :name

  @@all_created_stations = []

  def initialize(name)
    @name = name
    @trains_on_station = []
    @@all_created_stations << self
    register_instance
  end

  def self.all
    @@all_created_stations
  end

  def add_train(train)
    @trains_on_station << train
  end

  def remove_train(train)
    @trains_on_station.delete(train)
  end

  def count_trains(type)
    trains_on_station.filter { |train| train == type }
  end
end
