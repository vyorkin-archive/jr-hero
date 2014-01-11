class InputSystem < System
  THRUST      = Input::Keys::W
  TURN_LEFT   = Input::Keys::A
  TURN_RIGHT  = Input::Keys::D
  BREAK       = Input::Keys::S
  FIRE        = Input::Keys::F

  def tick(delta)
    @game.entities.with_input_responsive.each do |entity|
      entity.cannon.fire  if entity.cannon? && handle_for?(entity, FIRE)

      if entity.engine?
        entity.engine.on    if handle_for?(entity, THRUST)
        entity.engine.break if handle_for?(entity, BREAK)
      end

      if entity.wheel?
        entity.wheel.turn( 1) if handle_for?(entity, TURN_LEFT)
        entity.wheel.turn(-1) if handle_for?(entity, TURN_RIGHT)
      end

    end
  end

  private

  def handle_for?(entity, key)
    Gdx.input.isKeyPressed(key) &&
    entity.input_responsive.keys.include?(key)
  end
end
