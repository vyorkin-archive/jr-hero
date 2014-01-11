class Cannon < Component
  attr_accessor :ammo, :heat, :firing_rate,
                :last_firing_time

  state_machine :state, :initial => :idling do
    state :idling, :firing, :cooling_down

    event :fire do
      transition :idling => :firing,
                 :if => lambda { |cannon| cannon.can_fire? }
    end

    event :stop do
      transition :firing => :idling
    end

    event :cool_down do
      transition [:idling, :firing] => :cooling_down
    end

    after_transition :on => :fire do |cannon, transition|
      cannon.last_firing_time = TimeUtils.millis
    end
  end

  def initialize(ammo, firing_rate = 5.0)
    @ammo, @firing_rate = ammo, firing_rate * 50.0
    @heat, @last_firing_time = 0.0, 0.0
    super()
  end

  def can_fire?
    @firing_rate < TimeUtils.millis - @last_firing_time
  end
end
