class Wheel < Component
  attr_accessor :turn_speed, :angle, :steering

  def initialize(turn_speed = 1.0)
    @turn_speed = turn_speed
    @direction = 0.0
    super()
  end

  def turn(direction)
    @angle = direction * @turn_speed
    @steering = true
  end
end
