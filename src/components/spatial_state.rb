class SpatialState < Component
  class << self
    def centered(dx = 0, dy = 0)
      new(0, 0, dx, dy).center!
    end
  end

  attr_accessor :x, :y, :dx, :dy

  def initialize(x = 0, y = 0, dx = 0, dy = 0)
    @x, @y, @dx, @dy = x, y, dx, dy
    super()
  end

  def center!
    @x = Gdx.graphics.getWidth / 2.0
    @y = Gdx.graphics.getHeight / 2.0
    self
  end

  def stop!
    @dx, @dy = 0, 0
    self
  end
end
