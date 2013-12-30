class LevelScreen < GameScreen
  def initialize(game)
    @camera = GameCamera.new
    super(game)
  end

  def getCamera
    @camera
  end

  def show
    Gdx.input.setInputProcessor(self)
    @game.music.stop
    @game.music.play(R::Music::LEVEL)
    super()
  end

  def draw(delta)
  end

  def update(delta)
  end
end
