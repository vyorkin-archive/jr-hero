class BulletSystem < System
  def tick(delta)
    @game.entities.of(Bullet).each do |bullet|
      bullet.spatial_state.thrust(bullet.speed)
      bullet.spatial_state.move
      bullet.lifetime.update
      bullet.destroy if bullet.lifetime.dead?
    end
  end
end
