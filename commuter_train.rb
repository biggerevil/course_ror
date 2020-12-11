# frozen_string_literal: true

require_relative 'train'

class CommuterTrain < Train
  def initialize(number)
    super(number, :comm)
  end
end
