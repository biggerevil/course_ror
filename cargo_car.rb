# frozen_string_literal: true

require_relative 'car'

class CargoCar < Car
  attr_accessor :capacity
  attr_reader :taken_capacity

  def initialize(num, capacity)
    super(num)
    @type = :cargo
    @capacity = capacity
    @taken_capacity = 0
  end

  def take_capacity(how_much)
    raise RuntimeError if how_much > free_capacity

    @taken_capacity += how_much
  end

  def free_capacity
    @capacity - @taken_capacity
  end
end
