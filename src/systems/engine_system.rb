class EngineSystem < System
  def tick(delta)
    @game.entities.tagged(:ship).each do |entity|
      engine = entity.engine
      spatial_state = entity.spatial_state

      if engine.active?
        if entity.fuel?
          fuel = entity.fuel

          if fuel.remaining > 0
            fuel.burn(engine.acceleration * engine.fuel_consumption)
            spatial_state.thrust(engine.acceleration)
          end
        else
          spatial_state.thrust(engine.acceleration)
        end
      elsif engine.breaking?
        spatial_state.thrust(-engine.acceleration)
      end

      entity.engine.off
      spatial_state.move
    end
  end
end
