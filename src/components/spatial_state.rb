class SpatialState < Component
  class << self
    def centered(velocity = 0.0)
      new(0, 0, velocity).center!
    end
  end

  attr_accessor :x, :y, :velocity

  def initialize(x = 0, y = 0, velocity = 0.0)
    @x, @y, @velocity = x, y, velocity
    super()
  end

  def center!
    @x = Gdx.graphics.getWidth / 2.0
    @y = Gdx.graphics.getHeight / 2.0
    self
  end

  def move(rotation)
    @x += @velocity * Math.sin(rotation * Math::PI / 180.0)
    @y += @velocity * Math.cos(rotation * Math::PI / 180.0)
  end

  def stop
    @velocity = 0.0
    self
  end
end
