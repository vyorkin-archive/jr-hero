class Lifetime < Component
  attr_reader :total, :max

  def initialize(max)
    @total = 0.0
    @max = max
  end

  def update
    @total += delta
  end

  def dead?
    @total > @max
  end
end
