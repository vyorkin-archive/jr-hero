require 'spatial_state'
require 'renderable'
require 'game_screen'

class DemoScreen < GameScreen
  attr_reader :camera, :spatial_state, :rotation, :translation

  def initialize(game)
    @camera = OrthographicCamera.new(Settings::WIDTH, Settings::HEIGHT)
    super(game)
  end

  def show
    Gdx.input.setInputProcessor(self)

    @camera.setToOrtho(false, Settings::WIDTH, Settings::HEIGHT)
    @shape_renderer = ShapeRenderer.new

    @rotation = 0.0
    @translation = Vector2.new
    @spatial_state = SpatialState.centered(Vector2.new(0, 1))
    @atlas = @game.assets.get(R::Atlas::SHOOTER, TextureAtlas.java_class)
    @sprite = @atlas.createSprite(R::Sprite::Ship::CARROT)
    @renderable = Renderable.new(@sprite, @game.batch)

    super()
  end

  def resize(width, height)
    super(width, height)
  end

  def draw(delta)
    @camera.update
    @camera.apply(Gdx.gl10)
    @renderable.sprite.setRotation(@spatial_state.facing.angle - 90.0)
    @renderable.sprite.setPosition(@spatial_state.position.x, @spatial_state.position.y)
    @renderable.render
  end

  def draw_triangle(delta)
    @shape_renderer.setProjectionMatrix(camera.combined)
    @shape_renderer.begin(ShapeType::Filled)

    @shape_renderer.setColor(1, 1, 1, 1)
    @shape_renderer.identity

    @shape_renderer.rotate(0.0, 0.0, 1.0, @rotation)
    @shape_renderer.translate(@translation.x, @translation.y, 0.0)

    @shape_renderer.triangle(
      @spatial_state.x - 20, @spatial_state.y,
      @spatial_state.x + 20, @spatial_state.y,
      @spatial_state.x, @spatial_state.y + 20
    )

    @shape_renderer.end
  end

  def update(delta)
    @spatial_state.turn(-1) if Gdx.input.isKeyPressed(Input::Keys::D)
    @spatial_state.turn(1) if Gdx.input.isKeyPressed(Input::Keys::A)

    @spatial_state.thrust(0.04) if Gdx.input.isKeyPressed(Input::Keys::W)
    @spatial_state.thrust(-0.04) if Gdx.input.isKeyPressed(Input::Keys::S)

    @spatial_state.stop if  Gdx.input.isKeyPressed(Input::Keys::SPACE)

    @spatial_state.move
  end
end
