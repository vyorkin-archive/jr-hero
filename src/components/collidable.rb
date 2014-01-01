class Collidable < Component
  def initialize(shape = nil)
    @shape = shape
    super()
  end
end
