java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.math.Rectangle
java_import com.badlogic.gdx.math.Vector2
java_import com.badlogic.gdx.math.Vector3
java_import com.badlogic.gdx.utils.Scaling

class GameCamera < OrthographicCamera
  attr_reader :width, :height, :aspect_ratio,
              :viewport

  def initialize(width, height)
    @width, @height = width, height
    @aspect_ratio = width.to_f / height
    @viewport = Rectangle.new

    position.set(width / 2.0, height / 2.0, 0)
  end

  def refresh
    update
    apply(Gdx.gl10) unless Settings.useGL20
    updateViewport
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

    size.set(Scaling.fit.apply(@width, @height, width, height))

    crop.sub(size)
    crop.scl(0.5)

    viewport = Rectangle.new(crop.x, crop.y, size.x, size.y)
  end

  def unproject(x, y)
    vector = Vector3.new(x, y, 0)
    super(vector, viewport.x, viewport.y,
          viewport.width, viewport.height)

    Vector2.new(vector.x, vector.y)
  end

  def size
    Vector2.new(@width, @height)
  end
end
