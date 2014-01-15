class EntityFactory
  include ScreenHelper

  ENEMY_SPRITES = [
    R::Sprite::Enemy::TRANSFORMER,
    R::Sprite::Enemy::RAPTOR,
    R::Sprite::Enemy::RING,
    R::Sprite::Enemy::BUG,
    R::Sprite::Enemy::WORM,
    R::Sprite::Enemy::ALIEN,
    R::Sprite::Enemy::SUKHOI
  ]

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
    bullet.damage = entity.cannon.bullet[:damage]
    bullet.speed  = entity.cannon.bullet[:speed]

    bullet << Lifetime.new(0.30)

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
    entity = create_ship(R::Sprite::Ship::GENCORE)
    entity.add_tag(:player)
    entity << @component_factory.player_breakable
    entity << InputResponsive.new([
               Input::Keys::A, Input::Keys::W,
               Input::Keys::D, Input::Keys::S,
               Input::Keys::F
             ])
  end

  def create_random_enemy_ship
    position = Vector2.new(
      rand(10..640 - 10),
      rand(10..480 - 10)
    )
    create_enemy_ship(
      ENEMY_SPRITES[rand(0..ENEMY_SPRITES.size - 1)],
      position
    )
  end

  def create_enemy_ship(kind, position)
    entity = create_ship(kind, position)
    entity.add_tag(:enemy)
    entity << EnemyAi.new(200.0, 150.0)
    entity << @component_factory.enemy_breakable
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
    entity << @component_factory.wheel
    entity << @component_factory.fast_engine
    entity << @component_factory.player_cannon
    entity << @component_factory.fuel
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
