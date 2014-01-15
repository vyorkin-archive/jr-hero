class CollisionSystem < System
  def tick(delta)
    update
    check_bullet_collisions
  end

  private

  def update
    @game.entities.with_collidable.each do |e|
      e.collidable.update
    end
  end

  def check_bullet_collisions
    bullets  = @game.entities.tagged(:bullet)
    entities = @game.entities.with_collidable - bullets

    entities_to_destroy = []

    bullets.each do |bullet|
      entities.each do |entity|
        if overlaps?(entity.collidable, bullet.collidable)
          if entity.breakable?
            breakable = entity.breakable

            breakable.hit(bullet.damage)
            @game.sound.play(R::Sound::Hit::PLAYER)
          else
            entities_to_destroy << entity
          end
          entities_to_destroy << bullet
        end
      end
    end

    entities_to_destroy.each { |entity| entity.destroy }
  end

  def overlaps?(source, target)
    Intersector.overlapConvexPolygons(source.polygon, target.polygon)
  end
end
