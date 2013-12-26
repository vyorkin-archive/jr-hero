require 'minitest/unit'
require 'active_support/core_ext/object'
require 'management/entity_manager'
require 'components/component'

class EntityManagerTest < MiniTest::Unit::TestCase
  def setup
    @manager = EntityManager.new
  end

  def test_create_entity
    entity = @manager.create

    assert entity.present?
    assert_equal 1, @manager.all.size
    assert_equal entity, @manager.all.first
  end

  def test_create_tagged_entity
    entity = @manager.create("spaceship")

    assert entity.present?
    assert_equal 1, @manager.all.size
    assert_equal entity, @manager.all.first
    assert_equal ["spaceship"], @manager.tags(entity)
  end

  def test_get_entities_by_tag
    rabbits = [
      @manager.create("rabbit"),
      @manager.create("rabbit")
    ]
    assert_equal rabbits, @manager.tagged("rabbit")
  end

  def test_destroy_entity
    dog1 = @manager.create("dog")
    dog2 = @manager.create("dog")

    assert_equal 2, @manager.tagged("dog").size
    assert_equal ["dog"], @manager.tags(dog1)

    @manager.destroy(dog1)

    assert @manager.tags(dog1).empty?
    assert_equal 1, @manager.tagged("dog").size
  end

  def test_add_components
    ship1 = @manager.create("ship")
    ship2 = @manager.create("ship")

    @component1 = Component.new
    @component2 = Component.new

    ship1.add(@component1, @component2)

    assert ship1.has_component_of? Component
    assert ship1.has_component? @component1

    assert_equal [@component1, @component2], ship1.components_of(Component)
    assert_equal [@component1, @component2], ship1.components

    assert_equal [ship1], @manager.entities_with_component_of(Component)
  end
end
