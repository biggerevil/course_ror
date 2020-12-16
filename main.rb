# frozen_string_literal: true

require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'commuter_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'commuter_car'
require_relative 'interface'

interface = Interface.new
interface.start

# train = Train.new("132-4k", :cargo)
# train2 = Train.new("fj21j", :comm)
# puts "Train with number 132-4k = #{Train.find("132-4k").inspect}"
# puts "Train with number fj21j = #{Train.find("fj21j").inspect}"
# puts
#
# train.vendor_name = "zlato"
# puts "train.vendor_name = #{train.vendor_name}"
# puts "Train.instances == #{Train.instances}"
# puts
#
# station = Station.new('lih')
# station2 = Station.new('bor')
# puts "All stations = #{Station.all}"
# puts "Station.instances == #{Station.instances}"
