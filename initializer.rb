require 'java'

require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx.jar'

{
  'com.badlogic.gdx' => %w(ApplicationListener Game Gdx Screen Input InputAdapter InputMultiplexer),
  'com.badlogic.gdx.assets' => %w(AssetManager),
  'com.badlogic.gdx.graphics' => %w(GL10 Texture Camera OrthographicCamera Color),
  'com.badlogic.gdx.graphics.g2d' => %w(Animation BitmapFont SpriteBatch Sprite TextureAtlas TextureRegion),
  'com.badlogic.gdx.graphics.glutils' => ['ShapeRenderer', 'ShapeRenderer::ShapeType'],
  'com.badlogic.gdx.audio' => %w(Music Sound),
  'com.badlogic.gdx.math' => %w(Vector2 Vector3 Rectangle Circle Polygon Intersector),
  'com.badlogic.gdx.utils' => %w(Scaling TimeUtils),
  'com.badlogic.gdx.scenes.scene2d' => %w(Actor Group InputListener Stage),
  'com.badlogic.gdx.scenes.scene2d.actions' => %w(Actions MoveToAction RunnableAction ),
  'com.badlogic.gdx.scenes.scene2d.ui' => %w(Skin Table),
  'com.badlogic.gdx.maps.tiled' => %w(TiledMap TmxMapLoader),
  'com.badlogic.gdx.maps.tiled.renderers' => %w(OrthogonalTiledMapRenderer),
  'com.badlogic.gdx.assets.loaders.resolvers' => %w(InternalFileHandleResolver),
  'com.badlogic.gdx.backends.lwjgl' => %w(LwjglPreferences LwjglApplication LwjglApplicationConfiguration)
}.each do |package, klasses|
  klasses.each { |klass| eval("java_import %s.%s" % [package, klass]) }
end

GdxArray = com.badlogic.gdx.utils.Array

# Need a different root when inside the jar, luckily $0 is "<script>" in that case
RELATIVE_ROOT = $0['<'] ? 'jr-hero/' : ''
SRC_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'src'))

$LOAD_PATH << SRC_DIR
%w{
  camera common components entities management
  screens systems renderers factories
}.each do |dir|
  $LOAD_PATH << File.expand_path(dir, SRC_DIR)
end

require 'state_machine'
require 'active_support/core_ext/object'
require 'active_support/inflector'
require 'active_support/core_ext/string/inflections'

%w{
  settings resources system utils component entity
  entity_manager renderer lru_cache screen_helper
  game_camera game_screen input_responsive spatial_state lifetime renderable
  collidable breakable wheel engine fuel cannon bullet particle enemy_ai
  input_system collision_system breakable_system enemy_ai_system
  wheel_system engine_system cannon_system bullet_system rendering_system
  particle_system component_factory entity_factory locale_manager
  preferences_manager sound_manager music_manager loading_screen
  menu_screen level_screen demo_screen jr_hero_game
}.each do |file|
  puts "requiring %s" % file
  require file
end

