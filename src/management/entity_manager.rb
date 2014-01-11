#   :component class => {
#     :entity => {
#       :components => [component_id_1, ..., component_id_n]
#     }
#   }

require 'active_support/core_ext/object'
require 'common/utils'
require 'entities/entity'

class EntityManager
  include Utils

  UNTAGGED = '-'

  attr_reader :id

  def initialize
    @id = generate_id

    @entities_to_tags = Hash.new { |h, k| h[k] = [] }
    @tags_to_entities = Hash.new { |h, k| h[k] = [] }
    @component_map    = Hash.new { |h, k| h[k] = {} }
  end

  def create(options = {})
    klass = options[:class] || Entity
    tag   = create_tag(klass, options[:tag])

    entity = klass.new(generate_id, self)
    add_tag(entity, tag)

    entity
  end

  def destroy(entity)
    @entities_to_tags.delete(entity)
    [@component_map, @tags_to_entities].each do |hash|
      hash.each_value { |h| h.delete(entity) }
    end
  end

  def tags(entity)
    @entities_to_tags[entity]
  end

  def add_tag(entity, tag)
    @tags_to_entities[tag]    << entity
    @entities_to_tags[entity] << tag
  end

  def remove_tag(entity, tag)
    @tags_to_entities[tag].delete(entity)
    @entities_to_tags[entity].delete(tag)
  end

  def all
    @entities_to_tags.keys
  end

  def tagged(*tags)
    @tags_to_entities
      .select { |tag| tags.include? tag }
      .values.flatten
  end

  def of(*classes)
    tagged(*classes.map { |klass| klass.to_s.downcase.to_sym })
  end

  def components(entity)
    result = []
    @component_map.values.each do |hash|
      result += hash[entity] if hash[entity]
    end
    result
  end

  def components_of(entity, klass)
    @component_map[klass] ||= {}
    @component_map[klass][entity] ||= []
  end

  def with_component_of(*classes)
    classes.inject(all) do |entities, klass|
      entities = entities & @component_map[klass].keys
    end
  end

  def method_missing(name, *args, &block)
    source = name.to_s
    component_class = source.gsub('with_', '').classify.constantize
    define_singleton_method(name) { with_component_of(component_class) }
    self.send(name)
  end

  def respond_to_missing?(name, include_private = false)
    name.to_s.start_with?('with_')
  end

  def dump
    output = to_s

    all.each do |e|
      output << "\n #{e} (#{@entities_to_tags[e]})"
      comps = components(e)
      comps.each do |c|
        output << "\n   #{c.to_s}"
      end
    end

    output
  end

  def to_s
    "EntityManager {#{id}: #{all.size} managed entities}"
  end

  private

  def create_tag(klass, tag)
    (tag || (klass == Entity ? UNTAGGED : klass.to_s.downcase)).to_sym
  end
end
