require 'game_screen'

require 'player'

require 'input_responsive'
require 'spatial_state'
require 'renderable'
require 'collidable'
require 'engine'
require 'fuel'
require 'cannon'

require 'input_system'
require 'engine_system'
require 'bullet_system'
require 'rendering_system'

require 'debug_renderer'
require 'hud_renderer'

class LevelScreen < GameScreen
  def initialize(game)
    @camera = OrthographicCamera.new(Settings::WIDTH, Settings::HEIGHT)
    @viewport = Rectangle.new(0, 0, Settings::WIDTH, Settings::HEIGHT)

    @renderers = [
      DebugRenderer.new(game),
      HUDRenderer.new(game)
    ]
    @behavior_systems = [
      InputSystem.new(game),
      EngineSystem.new(game),
      BulletSystem.new(game)
    ]
    @rendering_systems = [
      RenderingSystem.new(game)
    ]

    super(game)
  end

  def show
    Gdx.input.setInputProcessor(self)
    @camera.setToOrtho(false, Settings::WIDTH, Settings::HEIGHT)

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
    @renderers.each { |r| r.render(delta) }
  end

  def update(delta)
    @behavior_systems.each { |s| s.tick(delta) }
  end

  def camera
    @camera
  end

  def load
    @game.assets.load R::Sound::Hit::ENEMY,  Sound.java_class
    @game.assets.load R::Sound::Hit::PLAYER, Sound.java_class
    @game.assets.load R::Sound::Hit::SHIELD, Sound.java_class

    @game.assets.load R::Sound::Explosion::SHORT, Sound.java_class
    @game.assets.load R::Sound::Explosion::LONG,  Sound.java_class
    @game.assets.load R::Sound::Explosion::BIG,   Sound.java_class
  end

  def unload
    @game.assets.unload R::Sound::Hit::ENEMY
    @game.assets.unload R::Sound::Hit::PLAYER
    @game.assets.unload R::Sound::Hit::SHIELD

    @game.assets.unload R::Sound::Explosion::SHORT
    @game.assets.unload R::Sound::Explosion::LONG
    @game.assets.unload R::Sound::Explosion::BIG
  end

  private

  def create_player
    @player = @game.entities.create(:class => Player)

    @player << SpatialState.centered
    @player << Renderable.new
    @player << Collidable.new
    @player << Engine.new
    @player << Fuel.new(25000)
    @player << Cannon.new(1, 500)
    @player << InputResponsive.new([
                 Input::Keys::A, Input::Keys::W,
                 Input::Keys::D, Input::Keys::S,
                 Input::Keys::F
               ])
  end
end
