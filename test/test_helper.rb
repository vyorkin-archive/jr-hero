require 'minitest/autorun'

if __FILE__ == $0
  $LOAD_PATH.unshift('src', 'test')
  Dir.glob('./test/**/*_test.rb') { |f| require f }
end
