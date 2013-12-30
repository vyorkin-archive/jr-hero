require 'game_screen'

class StageScreen < GameScreen
  def initialize(game)
    @stage = Stage.new(Settings::WIDTH, Settings::HEIGHT, true)
    super(game)
  end

  def getCamera
    @stage.camera
  end

  def show
    @stage.setViewport(Settings::WIDTH, Settings::HEIGHT, true)
    Gdx.input.setInputProcessor(@stage)
    super()
  end

  def dispose
    @stage.dispose
    super()
  end

  protected

  def update(delta)
    @stage.act(delta)
  end

  def draw(delta)
    @stage.draw
  end
end
