class EntityFactory
  include ScreenHelper

  def initialize(entities, component_factory, atlas)
    @entities, @component_factory = entities, component_factory
    @atlas = atlas
  end

  def create_particle_at(position)
    entity = @entities.create(:class => Particle)
    entity.color     = Color::WHITE
    entity.direction = rand(-Math::PI..Math::PI)
    entity.speed     = rand(3.125..9.25)
    entity.size      = rand(1..8)

    facing = Vector2.new
    facing.rotate(entity.direction)

    entity << SpatialState.new(position, facing)
    entity << Lifetime.new(rand(0.3..1.0))
  end

  def create_bullet_from(entity, kind)
    entity_spatial_state = entity.spatial_state
    entity_sprite = entity.renderable.sprite

    bullet = @entities.create(:class => Bullet)
    bullet.damage = 4.0
    bullet.speed = 1.0

    bullet << Lifetime.new(0.48)

    sprite = create_sprite(kind)
    renderable = Renderable.new
    renderable.sprite = sprite
    bullet << renderable

    position = entity_spatial_state.position.cpy
    facing   = entity_spatial_state.facing.cpy

    offset = Vector2.new(sprite.getWidth, sprite.getHeight)
    entity_offset = Vector2.new(entity_sprite.getWidth, entity_sprite.getHeight)
    entity_max_offset = [entity_offset.x, entity_offset.y].max

    bullet << Collidable.new(position, offset)

    spatial_state = SpatialState.new(position, facing)
    spatial_state.thrust(bullet.speed)
    spatial_state.position.add(spatial_state.velocity.cpy.mul(entity_max_offset))
    spatial_state.position.add(entity_offset.cpy.div(2.0).sub(offset.cpy.div(2.0)))

    bullet << spatial_state
  end

  def create_player_ship
    entity = create_ship(R::Sprite::Ship::USP)
    entity.add_tag(:player)
    entity << Breakable.new(100.0, 200.0)
    entity << InputResponsive.new([
               Input::Keys::A, Input::Keys::W,
               Input::Keys::D, Input::Keys::S,
               Input::Keys::F, Input::Keys::S
             ])
  end

  def create_enemy_ship(kind, position)
    entity = create_ship(kind, position)
    entity.add_tag(:enemy)
    entity << EnemyAi.new(200.0, 300.0)
    entity << Breakable.new(20.0, 40.0)
  end

  def create_ship(kind, position = screen_center)
    entity = @entities.create(:tag => :ship)

    entity << SpatialState.new(position, Vector2.new(0, 1))

    sprite = create_sprite(kind)
    renderable = Renderable.new
    renderable.sprite = sprite

    entity << renderable
    entity << Collidable.new(
      position, Vector2.new(sprite.getWidth, sprite.getHeight)
    )
    entity << Wheel.new(2.0)
    entity << Engine.new(0.05, 5.0)
    entity << Fuel.new(5000)
    entity << Cannon.new(1000)
  end

  private

  def create_sprite(kind)
    sprite = @atlas.createSprite(kind)
    sprite.setOrigin(sprite.getWidth / 2.0, sprite.getHeight / 2.0)
    sprite
  end

  def create_animation(kind)
  end
end
