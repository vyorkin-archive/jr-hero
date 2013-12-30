class System
  def initialize(game)
    @game = game
  end

  def tick(delta)
    raise RuntimeError, 'system should override #tick method'
  end

  protected

  def screen
    @game.screen
  end
end
