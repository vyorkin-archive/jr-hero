class GameCamera < OrthographicCamera
  attr_reader :width, :height, :aspect_ratio, :viewport

  def initialize
    @virtual_width = Settings::WIDTH
    @virtual_height = Settings::HEIGHT
    @virtual_aspect_ratio = @virtual_width.to_f / @virtual_height

    @viewport = Rectangle.new

    super(@virtual_width, @virtual_height)

    position.set(@virtual_width / 2, @virtual_height / 2, 0)
  end

  def refresh
    updateViewport
    update
    apply(Gdx.gl10) unless Settings::GL20
  end

  def updateViewport
    Gdx.gl.glViewport(
      viewport.x, viewport.y,
      viewport.width, viewport.height
    )
  end

  def resize(width, height)
    size = Vector2.new(0.0, 0.0)
    crop = Vector2.new(width, height)

    size.set(Scaling.fit.apply(@virtual_width, @virtual_height, width, height))

    crop.sub(size)
    crop.scl(0.5)

    @viewport = Rectangle.new(crop.x, crop.y, size.x, size.y)
  end

  def unproject(x, y)
    vector = Vector3.new(x, y, 0)
    position = Vector2.new(vector.x, vector.y)

    super(vector, @viewport.x, @viewport.y,
          @viewport.width, @viewport.height)

    position
  end

  def size
    Vector2.new(@virtual_width, @virtual_height)
  end
end
