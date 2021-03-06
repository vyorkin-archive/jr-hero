class EnemyAISystem < System
  def tick(delta)
    @game.entities.with_enemy_ai.each do |enemy|
      ai = enemy.enemy_ai
      ai.target ||= random_target

      facing = enemy.spatial_state.facing

      target_position = ai.target.spatial_state.position
      target_facing   = ai.target.spatial_state.facing

      to_target = target_position.cpy.sub(enemy.spatial_state.position)
      distance  = enemy.spatial_state.position.dst(target_position)

      facing_target = to_target.dot(to_target) > 0

      clockwise_turn = enemy.spatial_state.facing.crs(to_target) > 0
      if clockwise_turn
        enemy.wheel.turn(1)
      else
        enemy.wheel.turn(-1)
      end

      if ai.shooting_range < distance && facing_target
        enemy.engine.on
      elsif ai.shooting_range > distance
        enemy.cannon.fire if facing_target
      end

      speed = enemy.spatial_state.velocity.len
      enemy.engine.off if speed >= 1.0
    end
  end

  private

  def random_target
    @game.entities.tagged(:player).sample
  end
end
