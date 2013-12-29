class JrHeroGame < Game
  GAME_CLOCK_MULTIPLIER = 1

  attr_reader :clock, :preferences, :locales,
              :sound, :music, :assets, :batch, :font

  def initialize
    @running = true
  end

  def create
    @clock = Time.now.utc

    @preferences = PreferencesManager.new
    @assets      = AssetManager.new
    @locales     = LocaleManager.new
    @sound       = SoundManager.new(@preferences, @assets)
    @music       = MusicManager.new(@preferences, @assets)
    @entities    = EntityManager.new
    @batch       = SpriteBatch.new

    @assets.setLoader(TiledMap.class, TmxMapLoader.new(InternalFileHandleResolver.new))
    Texture.setAssetManager(@assets)

    Gdx.input.setCatchBackKey(true)

    preload

    @screen = LevelScreen.new(self)
    @screen.load
  end

  def preload
    @assets.load R::Sound::ENTER_CLICK, Sound.class
    @assets.load R::Sound::ENTER_HIT,   Sound.class
    @assets.load R::Sound::EXIT,        Sound.class
    @assets.load R::Skin::UI,           Skin.class
    @assets.load R::Font::Consolas,     BitmapFont.class
  end

  def render
    delta = Gdx.graphics.getDeltaTime

    Gdx.gl.glClearColor(0, 0, 0, 1)
    Gdx.gl.glClear(GL10.GL_COLOR_BUFFER_BIT)

    if @assets.queuedAssets == 0
      setScreen(@screen) if getScreen.nil?

      @batch.setProjectionMatrix(@screen.getCamera().combined)
      @batch.begin
      @screen.render(delta)
      @batch.end
    end
  end

  def running?
    @running
  end

  def pause
    super
    @preferences.save!
  end

  def log(message, *args)
    Gdx.app.log(Settings::LOG, message % args)
  end

  def dispose
    super
    [music, font, batch, assets].map(&:dispose)
  end
end
