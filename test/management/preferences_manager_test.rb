require 'minitest/unit'
require 'active_support/core_ext/object'
require 'management/preferences_manager'

java_import com.badlogic.gdx.backends.lwjgl.LwjglPreferences

class PreferencesManagerTest < MiniTest::Unit::TestCase
  class ::PreferencesManager
    def initialize(name)
      @storage = LwjglPreferences.new(name)
      @map = {}
    end
  end

  PREFS_DIR = "~/.prefs"
  TEST_DIR  = "test"
  FILE_NAME = "battlefrog"
  FILE_PATH = "#{PREFS_DIR}/#{TEST_DIR}/#{FILE_NAME}"

  def setup
    @manager = PreferencesManager.new("#{TEST_DIR}/#{FILE_NAME}")
  end

  def cleanup
    File.delete FILE_PATH if File.exists? FILE_PATH
  end

  def test_dynamic_proxy
    @manager.velocity = 100

    assert @manager.include? 'velocity'
    assert_equal @manager.velocity, 100
  end

  def test_save
    @manager.frog_name = 'Godzilla'
    @manager.fire_rate = 42.0
    @manager.save!

    assert File.exists?(File.expand_path(FILE_PATH))
  end
end

