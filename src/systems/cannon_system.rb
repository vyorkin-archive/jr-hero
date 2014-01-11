class CannonSystem < System
  def initialize(game, entity_factory)
    @entity_factory = entity_factory
    super(game)
  end

  def tick(delta)
    entities = @game.entities.with_component_of(Cannon, SpatialState)

    entities.each do |entity|
      cannon = entity.cannon
      if cannon.firing? && cannon.ammo > 0
        @entity_factory.create_bullet_from(entity, R::Sprite::Shot::DOUBLE)
        @game.sound.play(R::Sound::Shot::SINGLE)
        cannon.ammo -= 1
        cannon.stop
      end
    end
  end
end
