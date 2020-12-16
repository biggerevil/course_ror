# frozen_string_literal: true

require 'ostruct'
require_relative 'interface_data'

class Interface
  def initialize
    interface_data = InterfaceData.new
    @stations = interface_data.stations
    @routes = interface_data.routes
    @trains = interface_data.trains
    @commands = create_hash_with_functions
  end

  def start
    loop do
      puts "\nВыберите команду:"
      print_commands
      print 'Номер команды: '
      entered_number = gets.to_i

      break if entered_number == -1

      execute_command_with_index(entered_number)
    end
  end

  def execute_command_with_index(index)
    index = index.to_s
    @commands[index].command.call
  end

  def print_commands
    @commands.each do |number_of_command, struct|
      puts "#{number_of_command} = #{struct.name}"
    end
  end

  def seed
    seed = [2, 1, 1, 3, 4, 7, 8, 9]

    seed.each do |entered_from_seed|
      puts
      execute_command_with_index(entered_from_seed)
    end
    puts
  end

  protected

  # Все методы ниже только существуют только для внутреннего (внутри класса) пользования

  def create_hash_with_functions
    {
      '1' => create_struct('Создать станцию', method(:create_station_command)),
      '2' => create_struct('Создать поезд', method(:create_train_command)),
      '3' => create_struct('Управлять станциями', method(:manage_stations_command)),
      '4' => create_struct('Назначить маршрут поезду', method(:appoint_route_to_train_command)),
      '5' => create_struct('Добавить вагон к поезду', method(:add_car_to_train_command)),
      '6' => create_struct('Убрать вагон из поезду', method(:remove_car_from_train_command)),
      '7' => create_struct('Переместить поезд', method(:move_command)),
      '8' => create_struct('Посмотреть список станций', method(:show_stations_command)),
      '9' => create_struct('Посмотреть список поездов на станции', method(:show_trains_on_station)),
      '-1' => create_struct('Остановить программу', method(:print_error))
    }
  end

  def create_station_command
    print 'Введите название станции: '
    station_name = gets.chomp
    new_station = Station.new(station_name)
    @stations.push(new_station)
    puts 'Станция создана!'
  rescue RuntimeError => e
    puts "Было выброшено исключение - #{e.message}"
    puts 'Попробуйте снова!'
    retry
  end

  def create_train_command
    print 'Введите номер поезда: '
    train_number = gets.chomp
    puts
    puts 'Какой тип будет у поезда?'
    puts '1 - пассажирский'
    puts '2 - грузовой'
    entered_number = gets.to_i
    case entered_number
    when 1
      new_cargo_train = CargoTrain.new(train_number)
      @trains.push(new_cargo_train)
    when 2
      new_comm_train = CommuterTrain.new(train_number)
      @trains.push(new_comm_train)
    end
    puts "Поезд с номером #{train_number} создан!"
  rescue RuntimeError => e
    puts "Не удалось создать поезд - #{e.message}"
    puts 'Попробуйте снова!'
    retry
  end

  def manage_stations_command
    puts 'Что вы хотите сделать?'
    puts '1 - Создать маршрут'
    puts '2 - Добавить станцию в маршрут'
    puts '3 - Удалить станцию из маршрута'
    entered_number = gets.to_i

    case entered_number
    when 1
      create_route
    when 2
      read_and_add_station_to_route
    when 3
      choose_and_delete_station_from_route
    end
  end

  def appoint_route_to_train_command
    puts 'Выберите маршрут:'
    print_routes
    route_index = gets.to_i
    puts 'Выберите поезд:'
    print_trains
    train_index = gets.to_i
    @trains[train_index].route = @routes[route_index]
    puts 'Маршрут назначен!'
  end

  def add_car_to_train_command
    puts 'Выберите поезд:'
    print_trains
    train_index = gets.to_i
    case @trains[train_index].type
    when :cargo
      new_cargo_car = CargoCar.new
      @trains[train_index].add_car(new_cargo_car)
    when :comm
      new_comm_car = CommuterCar.new
      @trains[train_index].add_car(new_comm_car)
    end
    puts 'Вагон добавлен!'
  end

  def remove_car_from_train_command
    puts 'Выберите поезд:'
    print_trains
    train_index = gets.to_i
    @trains[train_index].remove_car
    puts 'Один вагон убран!'
  end

  def move_command
    puts 'Выберите поезд:'
    print_trains
    train_index = gets.to_i
    puts 'Куда вы хотите переместить поезд?'
    puts '1 - вперёд'
    puts '2 - назад'
    entered_number = gets.to_i
    case entered_number
    when 1
      @trains[train_index].move_forward
    when 2
      @trains[train_index].move_back
    end
    nil
  end

  def show_stations_command
    puts 'Список станций:'
    @stations.each do |station|
      puts station.name
    end
  end

  def show_trains_on_station
    puts 'Выберите станцию:'
    print_stations
    station_index = gets.to_i
    puts
    puts "Поезда на станции #{@stations[station_index].name.strip}:"
    @stations[station_index].trains_on_station.each do |train_on_station|
      print train_on_station.number
    end
    puts
  end

  def print_routes
    counter = 0
    @routes.each do |route|
      print "#{counter} - "

      all_stations_of_route = route.all_stations
      print all_stations_of_route[0].name.strip
      all_stations_of_route.delete_at(0)

      all_stations_of_route.each do |station|
        print ", #{station.name}"
      end
      counter += 1
      puts
    end
  end

  def print_trains
    counter = 0
    @trains.each do |train|
      puts "#{counter} - Поезд с номером #{train.number}"
      counter += 1
    end
  end

  def print_stations(stations = @stations)
    counter = 0
    stations.each do |station|
      puts "#{counter} - #{station.name}"
      counter += 1
    end
  end

  def create_route
    puts 'Выберите первую станцию:'
    print_stations
    start_station_index = gets.to_i
    start_station = @stations[start_station_index]

    stations_copy = @stations.dup
    stations_copy.delete_at(start_station_index)

    puts 'Выберите последнюю станцию:'
    print_stations(stations_copy)
    end_station_index = gets.to_i
    end_station = stations_copy[end_station_index]

    new_route = Route.new(start_station, end_station)
    @routes.push(new_route)
    puts 'Маршрут создан!'
  end

  def create_struct(name, command)
    resulting_struct = OpenStruct.new
    resulting_struct.name = name
    resulting_struct.command = command
    resulting_struct
  end

  def read_and_add_station_to_route
    puts 'Выберите маршрут:'
    print_routes
    route_index = gets.to_i

    stations_copy = @stations.dup
    @routes[route_index].all_stations.each do |station|
      stations_copy.delete(station)
    end

    puts 'Выберите станцию:'
    counter = 0
    stations_copy.each do |station|
      puts "#{counter} - #{station.name}"
      counter += 1
    end
    station_to_add_index = gets.to_i
    @routes[route_index].add_station(stations_copy[station_to_add_index])
    puts 'Станция добавлена!'
  end

  def choose_and_delete_station_from_route
    puts 'Выберите маршрут:'
    print_routes
    route_index = gets.to_i

    puts 'Выберите станцию для удаления:'
    counter = 0
    @routes[route_index].intermediate_stations.each do |station|
      puts "#{counter} - #{station.name}"
      counter += 1
    end
    station_to_delete_index = gets.to_i
    @routes[route_index].intermediate_stations.delete_at(station_to_delete_index)
    puts 'Станция убрана!'
  end

  def print_error
    puts "Ответ никак не обрабатывается, ошибка. По идее этот ответ
          должен обрабатываться не в этой части кода (а в main)"
  end
end
