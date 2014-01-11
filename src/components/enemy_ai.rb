class EnemyAi < Component
  attr_accessor :run_distance, :shooting_range, :target

  def initialize(run_distance, shooting_range)
    @run_distance, @shooting_range = run_distance, shooting_range
    super()
  end

  state_machine :state, :initial => :attacking do
    state :running, :attacking

    event :attack   do; transition :running => :attacking; end
    event :run_away do; transition :attacking => :running; end
  end
end
