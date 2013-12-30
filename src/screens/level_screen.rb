require 'game_screen'

require 'player'

require 'input_responsive'
require 'spatial_state'
require 'renderable'
require 'engine'
require 'fuel'

require 'input_system'
require 'rendering_system'

class LevelScreen < GameScreen
  def initialize(game)
    @camera = GameCamera.new

    @behavior_systems  = [InputSystem.new(game)]
    @rendering_systems = [RenderingSystem.new(game)]

    super(game)
  end

  def show
    Gdx.input.setInputProcessor(self)
    start
    super()
  end

  def start
    create_player
    @game.music.play(R::Music::LEVEL)
  end

  def draw(delta)
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
