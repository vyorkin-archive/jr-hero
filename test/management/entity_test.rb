require 'minitest/unit'

class EntityTest < MiniTest::Unit::TestCase
  def setup
    @manager = EntityManager.new
  end

  def test_entity_dynamic_proxy
    entity = @manager.create
    entity << Component.new

    assert entity.component?
  end
end
