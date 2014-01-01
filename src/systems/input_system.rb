class InputSystem < System
  THRUST      = Input::Keys::W
  TURN_LEFT   = Input::Keys::A
  TURN_RIGHT  = Input::Keys::D

  def tick(delta)
    entities = @game.entities.with_component_of(InputResponsive)
    entities.each do |entity|
      entity.engine.on! if handle_for?(entity, THRUST) && entity.engine?

      if entity.renderable?
        renderable = entity.renderable

        renderable.rotate(delta * 100)  if handle_for?(entity, TURN_LEFT)
        renderable.rotate(delta * -100) if handle_for?(entity, TURN_RIGHT)
      end
    end
  end

  private

  def handle_for?(entity, key)
    Gdx.input.isKeyPressed(key) &&
    entity.input_responsive.keys.include?(key)
  end
end
