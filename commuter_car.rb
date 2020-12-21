# frozen_string_literal: true

require_relative 'car'

class CommuterCar < Car
  attr_accessor :seats_amount
  attr_reader :taken_seats

  def initialize(num, seats_amount)
    super(num)
    @type = :comm
    @seats_amount = seats_amount
    @taken_seats = 0
  end

  def take_seat
    raise RuntimeError if @seats_amount.zero?

    @taken_seats += 1
  end

  def free_seats_amount
    @seats_amount - @taken_seats
  end
end
