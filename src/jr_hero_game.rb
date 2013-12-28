java_import com.badlogic.gdx.Game

class JrHeroGame < Game
  include ApplicationListener

  GAME_CLOCK_MULTIPLIER = 1

  attr_reader :clock, :preferences, :locales,
              :sound, :music, :assets, :batch, :font

  def initialize
    @running = true
  end

  def create
    @clock = Time.now.utc

    @preferences = PreferencesManager.new
    @assets = AssetManager.new
    @locales = LocaleManager.new
    @sound = SoundManager.new(@preferences, @assets)
    @music = MusicManager.new(@preferences, @assets)
    @entities = EntityManager.new
    @batch = SpriteBatch.new
  end

  def running?
    @running
  end

  def log(message)
    Gdx.app.log(Settings::LOG, message)
  end

  def dispose
    super
    [music, font, batch, assets].map(&:dispose)
  end
end
