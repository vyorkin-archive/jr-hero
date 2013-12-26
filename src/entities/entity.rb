class Entity
  attr_reader :id

  def initialize(id, manager)
    @id, @manager = id, manager
  end

  def tags
    @manager.tags(self)
  end

  def add(*components)
    components.each { |c| @manager.components_of(self, c.class).push(c) }
  end

  def remove(*components)
    components.each { |c| @manager.components_of(self, c.class).delete(c) }
  end

  def components
    @manager.components(self)
  end

  def components_of(klass)
    @manager.components_of(self, klass)
  end

  def has_component_of?(klass)
    components_of(klass).any?
  end

  def has_component?(component)
    components_of(component.class).include?(component)
  end

  def destroy
    @manager.destroy(self)
  end
end
