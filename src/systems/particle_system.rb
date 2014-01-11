class ParticleSystem < System
  def tick(delta)
    @game.entities.of(Particle).each do |particle|
      particle.spatial_state.thrust(particle.speed)
      particle.color.a -= 0.05

      particle.lifetime.update
      particle.destroy if particle.lifetime.dead?
    end
  end
end
