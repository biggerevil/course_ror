# frozen_string_literal: true

class InterfaceData
  attr_accessor :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end
end
