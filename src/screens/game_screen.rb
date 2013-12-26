java_import com.badlogic.gdx.InputAdapter
java_import com.badlogic.gdx.Screen
java_import com.badlogic.gdx.graphics.Camera

class GameScreen
  include Screen
  include InputAdapter

  attr_reader :done

  def done!
    @done = true
  end

  # TODO: How to interface with "disposable"?

  def load
  end
  def unload
  end
end

