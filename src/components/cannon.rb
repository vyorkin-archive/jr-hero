class Cannon < Component
  HEAT_MAX = 10.0

  attr_reader :bullet
  attr_accessor :ammo, :heat,
                :heat_rate, :firing_rate,
                :last_firing_time

  state_machine :state, :initial => :idling do
    state :idling, :firing, :overheat

    event :fire do
      transition :idling => :firing,
                 :if => lambda { |cannon| cannon.can_fire? }
    end

    event :stop do
      transition :firing => :idling
    end

    event :overheat do
      transition [:idling, :firing] => :overheat
    end

    after_transition :on => :fire do |cannon, transition|
      cannon.last_firing_time = TimeUtils.millis
    end
  end

  def initialize(bullet, ammo, heat_rate, firing_rate = 5.0)
    @bullet = bullet
    @ammo, @firing_rate = ammo, firing_rate * 50.0
    @heat_rate = heat_rate
    @heat, @last_firing_time = 0.0, 0.0
    super()
  end

  def can_fire?
    @firing_rate < TimeUtils.millis - @last_firing_time
  end

  def heat_up
    @heat += @heat_rate
    overheat if @heat > HEAT_MAX
  end

  def cool_down
    @heat -= @heat_rate
    stop if @heat < HEAT_MAX
  end
end
