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

  def count_trains(type)
    trains_on_station.filter { |train| train == type }
  end
end

