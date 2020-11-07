class Station
  attr_reader :trains_on_station, :name

  def initialize(name)
    @name = name
    @trains_on_station = []
  end

  def add_train(train)
    @trains_on_station << train
  end

  def remove_train(train)
    @trains_on_station.delete(train)
  end

  def count_trains
    # cargo = груз, грузовой
    cargo_trains_number = 0
    # commuter = пассажир, пассажирский
    commuter_trains_number = 0

    @trains_on_station.each do |train|
      if train.type == 'cargo'
        cargo_trains_number += 1
      elsif train.type == 'commuter'
        commuter_trains_number += 1
      end
    end

    puts "Cargo trains = #{cargo_trains_number}, Commuter trains = #{commuter_trains_number}"
  end
end
