# frozen_string_literal: true

require_relative 'vendor'

class Car
  include Vendor
  attr_reader :num, :type

  def initialize(num)
    @num = num
  end
end
