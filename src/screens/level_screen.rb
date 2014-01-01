require 'game_screen'

require 'player'

require 'input_responsive'
require 'spatial_state'
require 'renderable'
require 'engine'
require 'fuel'

require 'input_system'
require 'engine_system'
require 'bullet_system'
require 'rendering_system'

class LevelScreen < GameScreen
  def initialize(game)
    @camera = OrthographicCamera.new(Settings::WIDTH, Settings::HEIGHT)
    @viewport = Rectangle.new(0, 0, Settings::WIDTH, Settings::HEIGHT)

    @behavior_systems  = [
      InputSystem.new(game),
      EngineSystem.new(game),
      BulletSystem.new(game)
    ]

    @rendering_systems = [RenderingSystem.new(game)]

    super(game)
  end

  def show
    Gdx.input.setInputProcessor(self)
    @camera.position.set(Settings::WIDTH / 2, Settings::HEIGHT / 2, 0)
    start
    super()
  end

  def resize(width, height)
    super(width, height)
  end

  def start
    create_player
    @game.music.play(R::Music::LEVEL)
  end

  def draw(delta)
    @camera.update
    @camera.apply(Gdx.gl10)
    @rendering_systems.each { |s| s.tick(delta) }
  end

  def update(delta)
    @behavior_systems.each { |s| s.tick(delta) }
  end

  def camera
    @camera
  end

  private

  def create_player
    @player = @game.entities.create(:class => Player)

    @player << SpatialState.centered
    @player << Renderable.new
    @player << Engine.new
    @player << Fuel.new(250)
    @player << InputResponsive.new([
                 Input::Keys::A,
                 Input::Keys::W,
                 Input::Keys::D
               ])
  end
end
