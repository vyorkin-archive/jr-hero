java_import com.badlogic.gdx.InputAdapter
java_import com.badlogic.gdx.Screen
java_import com.badlogic.gdx.graphics.Camera

class GameScreen < InputAdapter
  include Screen

  def initialize(game)
    @game = game
  end

  def render(delta)
    update(delta)
    draw(delta)
  end

  def update
  end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def load;   end
  def unload; end

  def dispose
    unload
  end

  protected

  def update; end
  def draw; end

  def log(message, *args)
    @game.log(message, *args)
  end
end

