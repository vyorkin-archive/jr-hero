class RenderingSystem < System
  def initialize(game)
    @shape_renderer = ShapeRenderer.new
    super(game)
  end

  def tick(delta)
    @shape_renderer.setProjectionMatrix(screen.camera.combined)
    entities = @game.entities.with_component_of(Renderable, SpatialState)
    render(entities, delta)
  end

  private

  def render(entities, delta)
    @shape_renderer.begin(ShapeRenderer::ShapeType::Line)
    @shape_renderer.setColor(1, 1, 1, 1)

    entities.each do |entity|
      location   = entity.spatial_state
      renderable = entity.renderable

      @shape_renderer.triangle(
        location.x - 20, location.y,
        location.x + 20, location.y,
        location.x, location.y + 20
      )
    end

    @shape_renderer.end
  end
end
