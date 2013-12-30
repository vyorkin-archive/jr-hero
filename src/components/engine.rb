class Engine < Component
  attr_accessor :thrust, :on

  def initialize(thrust = 0.01)
    @on = false
    @thrust = thrust
    super()
  end
end
