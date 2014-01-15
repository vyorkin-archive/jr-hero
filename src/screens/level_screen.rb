
class LevelScreen < GameScreen
  include ScreenHelper

  attr_reader :camera

  def initialize(game)
    @camera = OrthographicCamera.new(Settings::WIDTH, Settings::HEIGHT)
    @viewport = Rectangle.new(0, 0, Settings::WIDTH, Settings::HEIGHT)

    super(game)
  end

  def show
    Gdx.input.setInputProcessor(self)
    @camera.setToOrtho(false, Settings::WIDTH, Settings::HEIGHT)

    @atlas = @game.assets.get(R::Atlas::SHOOTER, TextureAtlas.java_class)

    @component_factory = ComponentFactory.new(@atlas)
    @entity_factory = EntityFactory.new(@game.entities, @component_factory, @atlas)

    @rendering_system = RenderingSystem.new(@game)
    @particle_system = ParticleSystem.new(@game)
    @bullet_system = BulletSystem.new(@game)

    @updatable_systems = [
      CollisionSystem.new(@game),
      BreakableSystem.new(@game),
      InputSystem.new(@game),
      WheelSystem.new(@game),
      EngineSystem.new(@game),
      CannonSystem.new(@game, @entity_factory),
      EnemyAISystem.new(@game),
      @bullet_system, @particle_system
    ]

    start
    super()
  end

  def hide
    @atlas.dispose
    super()
  end

  def resize(width, height)
    super(width, height)
  end

  def start
    @entity_factory.create_player_ship

    enemies = [
      R::Sprite::Enemy::TRANSFORMER,
      R::Sprite::Enemy::RAPTOR,
      R::Sprite::Enemy::RING,
      R::Sprite::Enemy::BUG,
      R::Sprite::Enemy::WORM,
      R::Sprite::Enemy::ALIEN,
      R::Sprite::Enemy::SUKHOI
    ]

    2.times do
      position = Vector2.new(
        rand(10..screen_width - 10),
        rand(10..screen_height - 10)
      )
      @entity_factory.create_enemy_ship(
        enemies[rand(0..enemies.size - 1)],
        position
      )
    end

    puts "entity dump:"
    puts @game.entities.dump

    @game.music.play(R::Music::LEVEL)
  end

  def draw(delta)
    @camera.update
    @camera.apply(Gdx.gl10)

    @rendering_system.tick(delta)
  end

  def update(delta)
    @updatable_systems.each { |s| s.tick(delta) }
  end

  def load
    @game.assets.load R::Sound::Hit::ENEMY,   Sound.java_class
    @game.assets.load R::Sound::Hit::PLAYER,  Sound.java_class
    @game.assets.load R::Sound::Hit::SHIELD,  Sound.java_class
    @game.assets.load R::Sound::Shot::SINGLE, Sound.java_class

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
end
