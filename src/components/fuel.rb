class Fuel < Component
  attr_accessor :remaining

  def initialize(remaining)
    @remaining = remaining
    super()
  end

  def burn(qty)
    @remaining -= qty
    @remaining = 0 if @remaining < 0
  end

  def empty?
    @remaining == 0
  end
end
