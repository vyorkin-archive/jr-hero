require 'pry'

class RenderingSystem < System
  def initialize(game)
    @shape_renderer = ShapeRenderer.new
    super(game)
  end

  def tick(delta)
    @shape_renderer.setProjectionMatrix(screen.camera.combined)

    @game.entities
      .with_component_of(Renderable, SpatialState)
      .each { |entity| render_entity(entity) }
  end

  private

  def render_entity(entity)
    location = entity.spatial_state

    @shape_renderer.begin(ShapeRenderer::ShapeType::Filled)
    @shape_renderer.setColor(1, 1, 1, 1)
    @shape_renderer.circle(location.x, location.y, 10, 5)
    @shape_renderer.end
  end
end
