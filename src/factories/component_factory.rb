class ComponentFactory
  def initialize(atlas)
    @atlas = atlas
  end

  def fuel
    Fuel.new(5000)
  end

  def player_breakable
    Breakable.new(10000.0, 200.0)
  end

  def enemy_breakable
    Breakable.new(20.0, 40.0)
  end

  def player_cannon
    Cannon.new(double_bullet, 1000, 0.05, 5.0)
  end

  def enemy_cannon
    Cannon.new(circle_bullet, 100, 0.5, 0.01)
  end

  def fast_engine
    Engine.new(0.05, 5.0)
  end

  def slow_engine
    Engine.new(0.0000000001, 2.5)
  end

  def wheel
    Wheel.new(2.0)
  end

  private

  def circle_bullet
    {
      :damage => 1.0, :speed => 0.00000001, :range => 0.2,
      :sprite => R::Sprite::Shot::CIRCLE,
      :sound  => R::Sound::Shot::SINGLE
    }
  end

  def single_bullet
    {
      :damage => 4.0, :speed => 1.0, :range => 0.3,
      :sprite => R::Sprite::Shot::SINGLE,
      :sound  => R::Sound::Shot::SINGLE
    }
  end

  def double_bullet
    {
      :damage => 8.0, :speed => 1.4, :range => 0.4,
      :sprite => R::Sprite::Shot::DOUBLE,
      :sound  => R::Sound::Shot::SINGLE
    }
  end
end
