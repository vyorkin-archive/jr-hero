class BreakableSystem < System
  def tick(delta)
    @game.entities.with_breakable.each do |entity|
      if entity.breakable.dead?
        @game.sound.play(R::Sound::Explosion::SHORT)
        entity.destroy
      end
    end
  end
end
