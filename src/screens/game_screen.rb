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

  def show
    log 'showing screen %s' % to_s
  end

  def hide
    log 'hiding screen %s' % to_s
  end

  def resize(width, height)
    log 'resizing screen to %dx%d' % [width, height]
  end

  def pause
    log 'pausing screen %s' % to_s
  end

  def resume
    log 'resuming screen %s' % to_s
  end

  def load;   end
  def unload; end

  def done?
    @done
  end

  def done!
    @done = true
  end

  def dispose
    unload
  end

  def to_s
    self.class.name
  end

  def camera
    raise RuntimeError, 'screen should provide some camera'
  end

  protected

  def update(delta); end
  def draw(delta); end

  def log(message, *args)
    @game.log(message, *args)
  end
end

