class SpatialState < Component
  attr_accessor :position, :velocity, :facing

  def initialize(position, facing, velocity = Vector2.new)
    @position, @facing, @velocity = position, facing, velocity
    super()
  end

  def stop
    @velocity = Vector2.new
    self
  end

  def turn(angle)
    @facing.rotate(angle).nor
    self
  end

  def thrust(acceleration)
    @velocity.add(
      @facing.x * acceleration,
      @facing.y * acceleration
    )
    self
  end

  def move
    @position.add(@velocity)
    self
  end
end
