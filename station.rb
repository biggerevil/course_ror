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
    array_for_return = []

    puts "\nStart counting:"
    puts "trains_on_station = #{@trains_on_station}"

    @trains_on_station.each do |train|
      if train.type == type
        array_for_return << train
      end
    end

    puts "array_for_return = #{array_for_return}"
    puts "End counting\n\n"
    array_for_return
    # @trains_on_station
  end
end

