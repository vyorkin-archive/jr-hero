require 'initializer'
require 'minitest/autorun'
require 'minitest/pride'

if __FILE__ == $0
  $LOAD_PATH.unshift('src', 'test')
  Dir.glob('./test/**/*_test.rb') { |file| require file }
end
