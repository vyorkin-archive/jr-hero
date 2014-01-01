class InputSystem < System
  THRUST      = Input::Keys::W
  TURN_LEFT   = Input::Keys::A
  TURN_RIGHT  = Input::Keys::D
  BREAK       = Input::Keys::S
  FIRE        = Input::Keys::F

  def tick(delta)
    entities.with_input_responsive.each do |entity|
      entity.engine.on! if handle_for?(entity, THRUST) && entity.engine?

      if entity.renderable?
        renderable = entity.renderable

        renderable.rotate(1.5)  if handle_for?(entity, TURN_LEFT)
        renderable.rotate(-1.5) if handle_for?(entity, TURN_RIGHT)
      end

      if entity.cannon? && handle_for?(entity, FIRE)
        entity.cannon.ammo -= 1
        @game.sound.play(R::Sound::Hit::ENEMY)
      end
    end
  end

  private

  def handle_for?(entity, key)
    Gdx.input.isKeyPressed(key) &&
    entity.input_responsive.keys.include?(key)
  end
end
