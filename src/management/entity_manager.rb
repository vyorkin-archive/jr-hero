#   :component class => {
#     :entity => {
#       :markers => [marker_1, ..., marker_n],
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

    @component_map = Hash.new do |hash, key|
      hash[key] = Hash.new { |h, k| h[k] = [] }
    end
  end

  def create(options = {})
    klass = options[:class] || Entity
    tag   = create_tag(klass, options[:tag])

    entity = klass.new(generate_id, self)

    @tags_to_entities[tag]    << entity
    @entities_to_tags[entity] << tag

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

  def all
    @entities_to_tags.keys
  end

  def tagged(*tags)
    @tags_to_entities
      .select { |tag| tags.include? tag }
      .values.flatten
  end

  def components(entity)
    @component_map.values
      .select { |h| h.key? entity }
      .map(&:values).flatten
  end

  def components_of(entity, klass)
    @component_map[klass][entity]
  end

  def with_component_of(*classes)
    classes.inject(all) do |entities, klass|
      entities = entities & @component_map[klass].keys
    end
  end

  private

  def create_tag(klass, tag)
    tag || (klass == Entity ? UNTAGGED : klass.to_s.downcase)
  end
end
