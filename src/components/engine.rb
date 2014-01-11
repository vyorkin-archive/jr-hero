class Engine < Component
  attr_accessor :acceleration, :fuel_consumption

  state_machine :state, :initial => :idling do
    state :idling, :active, :breaking

    event :on     do; transition any => :active; end
    event :off    do; transition any => :idling; end
    event :break  do; transition any => :breaking; end
  end

  def initialize(acceleration, fuel_consumption)
    @acceleration, @fuel_consumption = acceleration, fuel_consumption
    super()
  end
end
