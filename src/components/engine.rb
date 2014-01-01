class Engine < Component
  attr_accessor :thrust

  state_machine :state, :initial => :idling do
    event :on do
      transition :idling => :active
    end

    event :off do
      transition :active => :idling
    end

    state :idling do
    end

    state :active do
    end
  end

  def initialize(thrust = 1)
    @thrust = thrust
    super()
  end
end
