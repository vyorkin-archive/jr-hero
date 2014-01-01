class Renderable < Component
  attr_accessor :rotation

  def initialize
    @rotation = 0
    super()
  end

  def rotate(delta)
    @rotation += delta
  end
end
