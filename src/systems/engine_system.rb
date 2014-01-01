class EngineSystem < System
  def tick(delta)
    @game.entities.with_engine.each do |entity|
      if entity.engine.active?
        amount = entity.engine.thrust * delta
        entity.fuel.burn(amount) if entity.fuel?
        entity.spatial_state.velocity += amount
        entity.engine.off
      end

      entity.spatial_state.move(entity.renderable.rotation)
    end
  end
end
