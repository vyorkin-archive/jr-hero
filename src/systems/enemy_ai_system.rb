require 'pry'

class EnemyAISystem < System
  def tick(delta)
    enemies = @game.entities.with_enemy_ai
    enemies.each do |enemy|
      ai = enemy.enemy_ai

      ai.target ||= random_target

      target_position = ai.target.spatial_state.position

      to_target = target_position.cpy.sub(enemy.spatial_state.position)
      distance = Math.sqrt(to_target.dot(to_target))

      if ai.running?
        too_close = ai.run_distance < distance
      elsif ai.attacking?
        if ai.shooting_range < distance
          enemy.engine.on
        elsif ai.shooting_range > distance
          enemy.engine.break
          enemy.cannon.fire
        else
          enemy.spatial_state.stop
        end
      end
    end
  end

  private

  def random_target
    @game.entities.tagged(:player).sample
  end
end
