class EngineSystem < System
  def tick(delta)
    entities = @game.entities.with_component_of(Engine, Fuel)
    entities.each do |entity|
      next if entity.engine.off? || entity.fuel.empty?

      amount = entity.engine.thrust * delta
      puts "moving by %f" % amount
      #entity.fuel.burn(amount)

      rotation = entity.renderable.rotation

      dx = -amount * Math.sin(rotation * Math::PI / 180.0);
      dy = -amount * Math.cos(rotation * Math::PI / 180.0);

      entity.spatial_state.dx += dx
      entity.spatial_state.dy += dy
      entity.spatial_state.x += delta * dx
      entity.spatial_state.y += delta * dy

      entity.engine.off!
    end
  end
end
