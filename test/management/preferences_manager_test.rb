require 'minitest/unit'
require 'management/preferences_manager'

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
  FILE_PATH = File.expand_path("#{PREFS_DIR}/#{TEST_DIR}/#{FILE_NAME}")

  def setup
    @manager = PreferencesManager.new("#{TEST_DIR}/#{FILE_NAME}")
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

    expected = File.exists? FILE_PATH

    assert expected

    File.delete FILE_PATH if expected
  end
end

