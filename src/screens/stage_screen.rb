java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.graphics.Camera
java_import com.badlogic.gdx.scenes.scene2d.Stage

class StageScreen < GameScreen
  def initialize
    @stage = Stage.new(Settings::WIDTH, Settings::HEIGHT, true)
  end

  def camera
    @stage.camera
  end

  def show
    super
    @stage.setViewport(Settings::WIDTH, Settings::HEIGHT, true)
    Gdx.input.setInputProcessor(@stage)
  end

  protected

  def update(delta)
    @stage.act(delta)
  end

  def draw(delta)
    @stage.draw
  end
end
