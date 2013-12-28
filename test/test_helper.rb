require 'java'

require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-backend-lwjgl.jar'
require 'lib/java/libgdx-nightly-20131204/gdx-natives.jar'
require 'lib/java/libgdx-nightly-20131204/gdx.jar'

require 'minitest/autorun'

if __FILE__ == $0
  $LOAD_PATH.unshift('src', 'test')
  Dir.glob('./test/**/*_test.rb') { |f| require f }
end
