require_relative 'car'

class CommCar < Car
  def initialize
    super
    @type = :comm
  end
end
