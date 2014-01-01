require 'java'

require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx.jar'

java_import com.badlogic.gdx.ApplicationListener
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Screen
java_import com.badlogic.gdx.Input
java_import com.badlogic.gdx.InputAdapter
java_import com.badlogic.gdx.InputMultiplexer
java_import com.badlogic.gdx.assets.AssetManager
java_import com.badlogic.gdx.graphics.GL10
java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.Camera
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.g2d.Animation
java_import com.badlogic.gdx.graphics.g2d.BitmapFont
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.TextureRegion

java_import com.badlogic.gdx.graphics.glutils.ShapeRenderer

# TODO: Doesn't work. How to import this?
#       Maybe the last nightlies is somehow different? Check this out!
#java_import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType

java_import com.badlogic.gdx.audio.Music
java_import com.badlogic.gdx.audio.Sound

java_import com.badlogic.gdx.math.Vector2
java_import com.badlogic.gdx.math.Vector3
java_import com.badlogic.gdx.math.Rectangle
java_import com.badlogic.gdx.math.Circle

java_import com.badlogic.gdx.utils.Scaling

java_import com.badlogic.gdx.scenes.scene2d.Actor
java_import com.badlogic.gdx.scenes.scene2d.Group
java_import com.badlogic.gdx.scenes.scene2d.InputListener
java_import com.badlogic.gdx.scenes.scene2d.Stage
java_import com.badlogic.gdx.scenes.scene2d.actions.Actions
java_import com.badlogic.gdx.scenes.scene2d.actions.MoveToAction
java_import com.badlogic.gdx.scenes.scene2d.actions.RunnableAction

java_import com.badlogic.gdx.scenes.scene2d.ui.Skin
java_import com.badlogic.gdx.scenes.scene2d.ui.Table

java_import com.badlogic.gdx.maps.tiled.TiledMap
java_import com.badlogic.gdx.maps.tiled.TmxMapLoader
java_import com.badlogic.gdx.maps.tiled.renderers.OrthogonalTiledMapRenderer

java_import com.badlogic.gdx.assets.loaders.resolvers.InternalFileHandleResolver

java_import com.badlogic.gdx.backends.lwjgl.LwjglPreferences
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration

# Need a different root when inside the jar, luckily $0 is "<script>" in that case
RELATIVE_ROOT = $0['<'] ? 'jr-hero/' : ''
SRC_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'src'))

$LOAD_PATH << SRC_DIR
%w{ camera common components entities management screens systems }.each do |dir|
  $LOAD_PATH << File.expand_path(dir, SRC_DIR)
end

require 'active_support/core_ext/object'
require 'active_support/inflector'
require 'active_support/core_ext/string/inflections'

%w{
  settings resources system utils component entity
  lru_cache game_camera jr_hero_game
}.each do |file|
  puts "requiring %s" % file
  require file
end
