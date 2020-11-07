load 'train.rb'
load 'station.rb'
load 'route.rb'

# Create stations
rizh_station = Station.new('Рижская')
tovar_station = Station.new('Товарная')
ostank_station = Station.new('Останкино')
lihov_station = Station.new('Лихоборы')
hovr_station = Station.new('Ховрино')

# Create routes
first_route = Route.new(rizh_station, hovr_station)
second_route = Route.new(tovar_station, lihov_station)
third_route = Route.new(tovar_station, ostank_station)

# Fill routes with intermediate stations
first_route.add_station(tovar_station)
first_route.add_station(lihov_station)
first_route.add_station(ostank_station)
first_route.delete_station(ostank_station)

second_route.add_station(rizh_station)
second_route.add_station(hovr_station)

third_route.add_station(hovr_station)

# train
# def initialize(number, type, wagonsAmount)
cargo1239 = Train.new(1239, 'cargo', 10)
comm482 = Train.new(482, 'comm', 5)
comm983 = Train.new(983, 'comm', 7)

puts "Train initial speed = #{cargo1239.speed}"
cargo1239.gain_speed
puts "Train speed after gainSpeed = #{cargo1239.speed}"
cargo1239.lose_speed
puts "Train speed after loseSpeed = #{cargo1239.speed}"
puts

puts "Wagons of cargo1239: #{cargo1239.wagons_amount}"
cargo1239.change_wagon(1)
puts "Wagons of cargo1239 after adding: #{cargo1239.wagons_amount}"
cargo1239.change_wagon(-1)
puts "Wagons of cargo1239 after decreasing: #{cargo1239.wagons_amount}"
puts

cargo1239.set_route(first_route)
print 'Route of cargo1239: '
cargo1239.route.all_stations
puts "Current station name of cargo1239 = #{cargo1239.current_station.name}"
cargo1239.move_forward
puts "Moved forward more time. Now the current stations is = #{cargo1239.current_station.name}"

print "And now let's check previous and next stations. Previous = #{cargo1239.get_previous_station.name}"
puts ", Next = #{cargo1239.get_next_station.name}"

cargo1239.move_forward
puts "Moved forward one more time. Now the current stations is = #{cargo1239.current_station.name}"
cargo1239.move_forward
puts "Moved forward even one more time. Now the current stations is = #{cargo1239.current_station.name}"
cargo1239.move_forward
puts

puts "Current station name of cargo1239 = #{cargo1239.current_station.name}"
cargo1239.move_back
puts "Moved back more time. Now the current stations is = #{cargo1239.current_station.name}"
cargo1239.move_back
cargo1239.current_station.count_trains
puts "Moved back one more time. Now the current stations is = #{cargo1239.current_station.name}"
cargo1239.move_back
puts "Moved back even one more time. Now the current stations is = #{cargo1239.current_station.name}"
cargo1239.move_back
puts
