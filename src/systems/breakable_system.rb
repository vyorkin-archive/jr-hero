class BreakableSystem < System
  def initialize(game)
    @entity_factory = game.screen.entity_factory
    super(game)
  end

  def tick(delta)
    @game.entities.with_breakable.each do |entity|
      if entity.breakable.dead?
        @game.sound.play(R::Sound::Explosion::SHORT)

        #6.times do
        #  @entity_factory.create_particle_at(
        #    entity.spatial_state.position
        #  )
        #end

        entity.destroy

        @entity_factory.create_random_enemy_ship
      end
    end
  end
end
