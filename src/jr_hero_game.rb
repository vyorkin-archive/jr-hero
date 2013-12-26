java_import com.badlogic.gdx.Game

class JrHeroGame < Game
  include ApplicationListener

  GAME_CLOCK_MULTIPLIER = 1

  attr_reader :clock, :preferences, :locales,
              :sound, :music, :assets, :batch, :font

  def initialize
    @next_screen = nil
    @running = true
  end

  def create
    @clock = Time.now.utc

    @preferences = PreferencesManager.new
    @locales = LocaleManager.new
    @sound = SoundManager.new
    @music = MusicManager.new
    @entities = EntityManager.new
    @assets = AssetManager.new
    @batch = SpriteBatch.new
    @font = BitmapFont.new
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
