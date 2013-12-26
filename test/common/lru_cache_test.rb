require 'minitest/unit'
require 'active_support/core_ext/object'
require 'common/lru_cache'

class LruCacheTest < MiniTest::Unit::TestCase
  def setup
    @cache = LruCache.new 3
  end

  def test_drops_old
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3
    @cache[:d] = 4

    assert_equal [[:d,4],[:c,3],[:b,2]], @cache.to_a
    assert_nil @cache[:a]
  end

  def test_fetch
    @cache[:a] = nil
    @cache[:b] = 2

    assert_equal @cache.fetch(:a){1}, nil
    assert_equal @cache.fetch(:c){3}, 3

    assert_equal [[:a,nil],[:b,2]], @cache.to_a
  end

  def test_getset
   assert_equal @cache.getset(:a){1}, 1
   @cache.getset(:b){2}
   assert_equal @cache.getset(:a){11}, 1
   @cache.getset(:c){3}
   assert_equal @cache.getset(:d){4}, 4

    assert_equal [[:d,4],[:c,3],[:a,1]], @cache.to_a
  end

  def test_pushes_lru_to_back
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3

    @cache[:a]
    @cache[:d] = 4

    assert_equal [[:d,4],[:a,1],[:c,3]], @cache.to_a
    assert_nil @cache[:b]
  end


  def test_delete
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3

    @cache.delete(:b)
    assert_equal [[:c,3],[:a,1]], @cache.to_a
    assert_nil @cache[:b]
  end

  def test_update
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3
    @cache[:a] = 99
    assert_equal [[:a,99],[:c,3],[:b,2]], @cache.to_a
  end

  def test_clear
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3

    @cache.clear
    assert_equal [], @cache.to_a
  end

  def test_grow
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3
    @cache.max_size = 4
    @cache[:d] = 4
    assert_equal [[:d,4],[:c,3],[:b,2],[:a,1]], @cache.to_a
  end

  def test_shrink
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3
    @cache.max_size = 1
    assert_equal [[:c,3]], @cache.to_a
  end

  def test_each
    @cache.max_size = 2
    @cache[:a] = 1
    @cache[:b] = 2
    @cache[:c] = 3

    pairs = []
    @cache.each do |pair|
      pairs << pair
    end

    assert_equal [[:c,3],[:b, 2]], pairs
  end
end
