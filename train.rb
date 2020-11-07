class Train
  attr_reader :wagons_amount, :speed, :route, :current_station, :route, :type

  def initialize(number, type, wagons_amount)
    @number = number
    @type = type
    @wagons_amount = wagons_amount
    @speed = 0
  end

  def change_wagon(number)
    if speed == 0
      if number > 0
        @wagons_amount += 1
      elsif number < 0
        @wagons_amount -= 1
      end
    end
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
    if current_station == route.initial_station
      @current_station.remove_train(self)
      @current_station = route.intermediate_stations[0]
      return
    end

    if (current_station != route.initial_station) && (current_station != route.end_station)
      index_of_station = route.intermediate_stations.find_index(current_station)
      # Check that current station is not the last of intermediateStations
      if index_of_station < (route.intermediate_stations.length - 1)
        @current_station.remove_train(self)
        @current_station = route.intermediate_stations[index_of_station + 1]
        @current_station.add_train(self)
      elsif index_of_station == (route.intermediate_stations.length - 1)
        @current_station.remove_train(self)
        @current_station = route.end_station
        @current_station.add_train(self)
      end
      return
    end

    # We will be here only if currentStaion == endStation
    puts 'Current station is the last station of route'
  end

  def move_back
    if current_station == route.end_station
      # Change currentStation from endStation to the last of intermediateStations
      @current_station.remove_train(self)
      @current_station = route.intermediate_stations[route.intermediate_stations.length - 1]
      @current_station.add_train(self)
      return
    end

    if (current_station != route.initial_station) && (current_station != route.end_station)
      index_of_station = route.intermediate_stations.find_index(current_station)
      # Check that current station is not the last of intermediateStations
      if index_of_station > 0
        @current_station.remove_train(self)
        @current_station = route.intermediate_stations[index_of_station - 1]
        @current_station.add_train(self)
      elsif index_of_station == 0
        @current_station.remove_train(self)
        @current_station = route.initial_station
        @current_station.add_train(self)
      end
      return
    end

    # We will be here only if currentStation == initialStation
    puts 'Current station is the first station of route'
  end

  def get_previous_station
    if current_station == route.initial_station
      puts 'We are on the first station of the route'
      return
    end

    return route.intermediate_stations[route.intermediate_stations.length - 1] if current_station == route.end_station

    # We are here only if currentStation is one of intermediateStations
    index_of_station = route.intermediate_stations.find_index(current_station)

    return route.initial_station if index_of_station == 0

    route.intermediate_stations[index_of_station - 1]
  end

  def get_next_station
    if current_station == route.end_station
      puts 'We are on the last station of the route'
      return
    end

    return route.intermediate_stations[0] if current_station == route.initial_station

    # We are here only if currentStation is one of intermediateStations
    index_of_station = route.intermediate_stations.find_index(current_station)

    return route.end_station if index_of_station == route.intermediate_stations.length - 1

    route.intermediate_stations[index_of_station + 1]
  end
end