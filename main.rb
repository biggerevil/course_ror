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
