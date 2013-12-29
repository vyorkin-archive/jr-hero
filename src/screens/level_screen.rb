class LevelScreen < GameScreen
  def initialize(game)
    super
    @camera = GameCamera.new(
      Settings::WIDTH, Settings::HEIGHT
    )
  end

  def getCamera
    @camera
  end

  def show
    Gdx.input.setInputProcessor(this)
    @game.music.stop
    @game.music.play
  end
end
