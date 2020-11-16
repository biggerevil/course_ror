require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'commuter_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'comm_car'
require_relative 'interface'

interface = Interface.new

# seed = [2, 1, 1, 3, 4, 7, 8, 9]

loop do
  puts "\nВыберите команду:"
  puts interface.print_commands
  print 'Номер команды: '
  entered_number = gets.to_i

  # seed.each do | entered_from_seed |
  #   puts
  #   interface.execute_command_with_index(entered_from_seed)
  # end
  # break
  # puts

  # FOR PROD
  break if entered_number == -1

  interface.execute_command_with_index(entered_number)
  # puts "remove next line with break before prod"
  # break
end
