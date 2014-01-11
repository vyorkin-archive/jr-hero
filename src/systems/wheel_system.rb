class WheelSystem < System
  def tick(delta)
    @game.entities
      .with_component_of(Wheel, SpatialState)
      .each do |entity|
        if entity.wheel.steering
          entity.spatial_state.turn(entity.wheel.angle)
          entity.wheel.steering = false
        end
      end
  end
end
