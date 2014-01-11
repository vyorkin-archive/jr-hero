class DebugRenderer < Renderer
  def render(delta)
    font.draw(batch, "FPS: %d" % Gdx.graphics.getFramesPerSecond, 8, 100)
  end
end
