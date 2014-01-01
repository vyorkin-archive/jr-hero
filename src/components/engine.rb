class Engine < Component
  attr_accessor :thrust

  def initialize(thrust = 10000)
    @on = false
    @thrust = thrust
    super()
  end

  def on!
    @on = true
  end

  def on?
    @on
  end

  def off?
    !@on
  end

  def off!
    @on = false
  end
end
