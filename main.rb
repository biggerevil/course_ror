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

# interface = Interface.new
# interface.start

train = Train.new(12, :cargo)
train2 = Train.new(4, :comm)
puts "Train with number 12 = #{Train.find(12).inspect}"
puts "Train with number 1 = #{Train.find(1).inspect}"
puts

train.vendor_name = "zlato"
puts "train.vendor_name = #{train.vendor_name}"
puts "Train.instances == #{Train.instances}"
puts

station = Station.new('lih')
station2 = Station.new('bor')
puts "All stations = #{Station.all}"
puts "Station.instances == #{Station.instances}"
