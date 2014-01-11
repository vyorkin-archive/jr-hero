require 'debug_renderer'
require 'hud_renderer'

class RenderingSystem < System
  def initialize(game)
    @shape_renderer = ShapeRenderer.new
    @renderers = [DebugRenderer.new(game), HUDRenderer.new(game)]
    super(game)
  end

  def tick(delta)
    @shape_renderer.setProjectionMatrix(screen.camera.combined)

    render_entities(delta)
    render_particles(delta)

    @renderers.each { |r| r.render(delta) }
  end

  private

  def render_entities(delta)
    entities = @game.entities.with_component_of(Renderable, SpatialState)
    entities.each do |entity|
      renderable = entity.renderable
      spatial_state = entity.spatial_state
      position = spatial_state.position


      if renderable.sprite
        check_screen_bounds(renderable, position)
        renderable.sprite.setRotation(spatial_state.facing.angle - 90.0)
        renderable.sprite.setPosition(position.x, position.y)
        renderable.sprite.draw(@game.batch)
      end

    end
  end

  def render_particles(delta)
    @shape_renderer.begin(ShapeRenderer::ShapeType::Filled)

    @game.entities.tagged(:particle).each do |particle|
      position = particle.spatial_state

      @shape_renderer.setColor(particle.color)
      @shape_renderer.rect(
        position.x - particle.size / 2.0,
        position.y - particle.size / 2.0,
        particle.size / 2.0,
        particle.size / 2.0
      )
    end

    @shape_renderer.end
  end

  private

  def check_screen_bounds(renderable, position)
    bounds = Vector2.new(
      Gdx.graphics.getWidth - renderable.sprite.getWidth,
      Gdx.graphics.getHeight - renderable.sprite.getHeight
    )

    position.x = bounds.x if position.x < 0
    position.x = 0 if position.x > bounds.x
    position.y = bounds.y if position.y < 0
    position.y = 0 if position.y > bounds.y
  end
end
