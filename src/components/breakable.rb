class Breakable < Component
  attr_accessor :health, :armor

  def initialize(health, armor)
    @health, @armor = health, armor
    super()
  end

  def alive?
    @health > 0
  end

  def dead?
    not alive?
  end

  def hit(damage)
    @health -= health_damage(damage)
    @armor  -= damage

    @health = 0 if @health < 0
    @armor  = 0 if @armor  < 0
  end

  private

  def health_damage(damage)
    @armor > 0 ? damage : damage / 10.0
  end
end
