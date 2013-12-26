#   :component class => {
#     :entity => [component_id1, ..., component_idn]
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

  def create(tag = nil)
    entity = Entity.new(generate_id, self)
    @tags_to_entities[tag] << entity
    @entities_to_tags[entity] << tag || UNTAGGED
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

  def entities_with_component_of(klass)
    @component_map[klass].keys
  end
end
