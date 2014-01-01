require 'minitest/unit'

class EntityManagerTest < MiniTest::Unit::TestCase
  class Spaceship < Entity
    def attack!; end
  end

  class LaserGun < Component; end
  class MachineGun < Component; end

  def setup
    @manager = EntityManager.new
  end

  def test_create_entity
    entity = @manager.create

    assert entity
    assert_equal 1, @manager.all.size
    assert_equal entity, @manager.all.first
  end

  def test_create_tagged_entity
    entity = @manager.create(:tag => "spaceship")

    assert entity
    assert_equal 1, @manager.all.size
    assert_equal entity, @manager.all.first
    assert_equal ["spaceship"], @manager.tags(entity)
  end

  def test_create_tagged_entity_with_class
    entity = @manager.create(:class => Spaceship)

    assert entity.is_a?(Spaceship)
    assert entity.methods.include? :attack!
    assert ["spaceship"], entity.tags
  end

  def test_get_entities_by_tag
    rabbits = [
      @manager.create(:tag => "rabbit"),
      @manager.create(:tag => "rabbit")
    ]
    assert_equal rabbits, @manager.tagged("rabbit")
  end

  def test_destroy_entity
    dog1 = @manager.create(:tag => "dog")
    dog2 = @manager.create(:tag => "dog")

    assert_equal 2, @manager.tagged("dog").size
    assert_equal ["dog"], @manager.tags(dog1)

    @manager.destroy(dog1)

    assert @manager.tags(dog1).empty?
    assert_equal 1, @manager.tagged("dog").size
  end

  def test_add_components
    ship1 = @manager.create(:tag => "ship")
    ship2 = @manager.create(:tag => "ship")

    @component1 = Component.new
    @component2 = Component.new

    ship1.add(@component1, @component2)

    assert ship1.has_component_of? Component
    assert ship1.has_component? @component1

    assert_equal [@component1, @component2], ship1.components_of(Component)
    assert_equal [@component1, @component2], ship1.components

    assert_equal [ship1], @manager.with_component_of(Component)
  end

  def test_with_component_of
    entity = @manager.create(:class => Spaceship)
    entity << LaserGun.new 
    entity << MachineGun.new

    assert_equal [entity], @manager.with_component_of(LaserGun, MachineGun)
  end

  def test_dynamic_proxy
    entity = @manager.create(:class => Spaceship)
    entity << Component.new

    assert_equal [entity], @manager.with_component
  end
end
