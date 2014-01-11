require 'minitest/unit'
require 'pry'

class EntityManagerTest < MiniTest::Unit::TestCase
  class Spaceship < Entity
    def attack!; end
  end
  class Rabbit < Entity
    def eat!; end
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
    entity = @manager.create(:tag => :spaceship)

    assert entity
    assert_equal 1, @manager.all.size
    assert_equal entity, @manager.all.first
    assert_equal [:spaceship], @manager.tags(entity)
  end

  def test_create_tagged_entity_with_class
    entity = @manager.create(:class => Spaceship)
    entity.add_tag(:player)

    assert entity.is_a?(Spaceship)
    assert entity.methods.include? :attack!
    assert [:spaceship, :player], entity.tags
  end

  def test_get_entities_by_tag
    rabbits = [
      @manager.create(:tag => :rabbit),
      @manager.create(:tag => :rabbit)
    ]
    assert_equal rabbits, @manager.tagged(:rabbit)
  end

  def test_get_entities_of
    entities = [
      @manager.create(:class => Spaceship),
      @manager.create(:class => Rabbit)
    ]
    assert_equal entities, @manager.of(Spaceship, Rabbit)
  end

  def test_destroy_entity
    dog1 = @manager.create(:tag => :dog)
    dog2 = @manager.create(:tag => :dog)

    assert_equal 2, @manager.tagged(:dog).size
    assert_equal [:dog], @manager.tags(dog1)

    @manager.destroy(dog1)

    assert @manager.tags(dog1).empty?
    assert_equal 1, @manager.tagged(:dog).size
  end

  def test_add_components
    ship1 = @manager.create(:tag => :ship)
    ship2 = @manager.create(:tag => :ship)

    @component1 = Component.new
    @component2 = LaserGun.new

    ship1 << @component1
    ship1 << @component2

    ship2 << @component2

    assert ship1.has_component_of? Component
    assert ship1.has_component_of? LaserGun
    assert ship1.has_component? @component1
    assert ship1.has_component? @component2

    assert_equal [@component1], ship1.components_of(Component)
    assert_equal [@component1, @component2], ship1.components

    assert_equal [ship1], @manager.with_component_of(Component)
  end

  def test_with_component_of
    entity1 = @manager.create(:class => Spaceship)
    entity2 = @manager.create(:tag => :dog)

    entity1 << LaserGun.new 
    entity1 << MachineGun.new

    assert_equal [entity1], @manager.with_component_of(LaserGun, MachineGun)
  end

  def test_dynamic_proxy
    entity1 = @manager.create(:class => Spaceship)
    entity2 = @manager.create(:tag => :ship)

    entity1 << Component.new
    entity2 << InputResponsive.new([])

    assert_equal [entity1], @manager.with_component
    assert_equal [entity2], @manager.with_input_responsive
  end
end
