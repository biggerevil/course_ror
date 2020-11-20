# frozen_string_literal: true

require_relative 'car'

class CommuterCar < Car
  def initialize
    super
    @type = :comm
  end
end
