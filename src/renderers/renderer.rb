class Renderer
  def initialize(game)
    @game = game
  end

  def render(delta)
    raise RuntimeError, 'renderer should override #render method'
  end

  protected

  def font
    @game.font
  end

  def batch
    @game.batch
  end
end
