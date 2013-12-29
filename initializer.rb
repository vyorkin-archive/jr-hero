require 'java'

require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx.jar'

java_import com.badlogic.gdx.ApplicationListener
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Input
java_import com.badlogic.gdx.InputAdapter
java_import com.badlogic.gdx.InputMultiplexer
java_import com.badlogic.gdx.graphics.GL10
java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.g2d.Animation
java_import com.badlogic.gdx.graphics.g2d.BitmapFont
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.TextureRegion

java_import com.badlogic.gdx.audio.Music
java_import com.badlogic.gdx.audio.Sound

java_import com.badlogic.gdx.math.Vector3

java_import com.badlogic.gdx.scenes.scene2d.Actor
java_import com.badlogic.gdx.scenes.scene2d.Group
java_import com.badlogic.gdx.scenes.scene2d.InputListener
java_import com.badlogic.gdx.scenes.scene2d.Stage
java_import com.badlogic.gdx.scenes.scene2d.actions.Actions
java_import com.badlogic.gdx.scenes.scene2d.actions.MoveToAction
java_import com.badlogic.gdx.scenes.scene2d.actions.RunnableAction

java_import com.badlogic.gdx.maps.tiled.TmxMapLoader
java_import com.badlogic.gdx.maps.tiled.renderers.OrthogonalTiledMapRenderer

java_import com.badlogic.gdx.backends.lwjgl.LwjglPreferences
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration

SRC_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'src'))

$LOAD_PATH << SRC_DIR
%w{ camera common components entities management screens systems }.each do |dir|
  $LOAD_PATH << File.expand_path(dir, SRC_DIR)
end

begin
  require 'pry'
rescue LoadError
end

require 'active_support/core_ext/object'
require 'active_support/inflector'

%w{ settings resources }.each { |file| require file }

require 'jr_hero_game'
