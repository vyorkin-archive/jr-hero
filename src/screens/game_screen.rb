class GameScreen < InputAdapter
  include Screen

  def initialize(game)
    @game = game
    super()
  end

  def render(delta)
    update(delta)
    draw(delta)
  end

  def show;   end
  def hide;   end
  def pause;  end
  def resume; end
  def load;   end
  def unload; end

  def resize(width, height); end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def dispose
    unload
  end

  protected

  def update(delta); end
  def draw(delta); end

  def log(message, *args)
    @game.log(message, *args)
  end
end

