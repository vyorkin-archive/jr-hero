
class JrHeroGame < Game
  attr_reader :preferences, :locales, :sound,
              :music, :assets, :batch, :font,
              :entities

  def initialize
    @running = true
  end

  def create
    @assets      = AssetManager.new
    @locales     = LocaleManager.new
    @entities    = EntityManager.new
    @batch       = SpriteBatch.new
    @font        = BitmapFont.new
    @preferences = PreferencesManager.new(Settings::PREFERENCES)
    @sound       = SoundManager.new(self)
    @music       = MusicManager.new(self)

    @preferences.music_muted  = true
    @preferences.sound_muted  = false
    @preferences.music_volume = Settings::MUSIC_VOLUME
    @preferences.sound_volume = Settings::SOUND_VOLUME
    @preferences.developer = Settings::DEVELOPER

    map_loader = TmxMapLoader.new(InternalFileHandleResolver.new)

    @batch.disableBlending
    @assets.setLoader(TiledMap.java_class, map_loader)
    Texture.setAssetManager(@assets)

    Gdx.input.setCatchBackKey(true)

    preload

    @screen = LevelScreen.new(self)
    @screen.load
  end

  def preload
    @assets.load R::Sound::Menu::ENTER_CLICK, Sound.java_class
    @assets.load R::Sound::Menu::ENTER_HIT,   Sound.java_class
    @assets.load R::Sound::Menu::EXIT,        Sound.java_class
    @assets.load R::Music::LEVEL,             Music.java_class
    @assets.load R::Atlas::SHOOTER,           TextureAtlas.java_class
  end

  def render
    delta = Gdx.graphics.getDeltaTime

    Gdx.gl.glClearColor(0, 0, 0, 1)
    Gdx.gl.glClear(GL10.GL_COLOR_BUFFER_BIT)

    if @assets.queuedAssets == 0
      setScreen(@screen) if screen.nil?

      @batch.setProjectionMatrix(@screen.camera.combined)
      @batch.begin
      @screen.render(delta)
      @batch.end
    else
      @assets.update
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
    Gdx.app.log(Settings::LOG, message % args) if @preferences.developer?
  end

  def dispose
    super
    [music, font, batch, assets].map(&:dispose)
  end

  alias_method :screen,  :getScreen
  alias_method :screen=, :setScreen
end
