module ScreenHelper
  def screen_center
    Vector2.new(screen_size).scl(0.5)
  end

  def on_screen(position, offset)
    position.x > 0 && position.x + offset.x < screen_width &&
    position.y > 0 && position.y + offset.y < screen_height
  end

  def screen_width
    Gdx.graphics.getWidth
  end

  def screen_height
    Gdx.graphics.getHeight
  end

  def screen_size
    Vector2.new(screen_width, screen_height)
  end
end
