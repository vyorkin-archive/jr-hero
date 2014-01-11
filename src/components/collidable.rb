class Collidable < Component
  def initialize(position, offset)
    @position, @offset = position, offset
    update
    super()
  end

  def update
    @points = [
      @position,
      Vector2.new(@position.x, @position.y + @offset.y),
      Vector2.new(@position.x + @offset.x, @position.y + @offset.y),
      Vector2.new(@position.x + @offset.x, @position.y)
    ]
  end

  def points
    @points
  end

  def vertices
    result = []
    @points.each do |vector|
      result << vector.x
      result << vector.y
    end
    result
  end

  def polygon
    Polygon.new(vertices.to_java(:float))
  end
end
