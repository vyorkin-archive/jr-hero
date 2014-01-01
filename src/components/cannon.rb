class Cannon < Component
  attr_accessor :ammo, :damage, :heat

  state_machine :state, :initial => :idling do
    state :idling do
    end

    state :firing do
    end

    state :cooling_down do
    end
  end

  def initialize(damage, ammo)
    @damage, @ammo = damage, ammo
    @heat = 0.0
  end
end
