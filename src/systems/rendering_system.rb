class RenderingSystem < System
  def initialize(game)
    @shape_renderer = ShapeRenderer.new
    super(game)
  end

  def tick(delta)
    @shape_renderer.setProjectionMatrix(screen.camera.combined)
    entities = @game.entities.with_component_of(Renderable, SpatialState)
    render(entities)
  end

  private

  def render(entities)
    @shape_renderer.begin(ShapeRenderer::ShapeType::Line)
    @shape_renderer.setColor(1, 1, 1, 1)

    entities.each do |entity|
      location = entity.spatial_state
      @shape_renderer.circle(location.x, location.y, 20, 3)
    end

    @shape_renderer.end
  end
end
