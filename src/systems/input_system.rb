require 'system'

class InputSystem < System
  THRUST      = Input::Keys::W
  TURN_LEFT   = Input::Keys::A
  TURN_RIGHT  = Input::Keys::D

  def tick(delta)
  end
end
