class Entity
  attr_reader :id

  def initialize(id, manager)
    @id, @manager = id, manager
  end

  def tags
    @manager.tags(self)
  end

  def add_tag(tag)
    @manager.add_tag(self, tag)
  end

  def remove_tag(tag)
    @amanger.remove_tag(self, tag)
  end

  def add(*items)
    items.each { |item| @manager.components_of(self, item.class).push(item) }
    self
  end

  def <<(component)
    add(component)
  end

  def remove(*items)
    items.each { |item| @manager.components_of(self, item.class).delete(item) }
    self
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

  def ==(other)
    self.id == other.id
  end

  def method_missing(name, *args, &block)
    source = name.to_s
    target = source.gsub('?', '').classify.constantize

    if source.end_with?('?')
      define_singleton_method(name) { has_component_of?(target) }
    else
      define_singleton_method(name) do
        array = components_of(target)
        plural_word?(source) ? array : array.first
      end
    end

    self.send(name)
  end

  def respond_to_missing?(name, include_private = false)
    name.to_s.end_with('?')
  end

  private

  def plural_word?(word)
    word.pluralize == word
  end
end
