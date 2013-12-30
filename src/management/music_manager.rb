class MusicManager < AudioManager
  def initialize(game)
    @current = nil
    super(game)
  end

  def play(file_name, loop = true)
    return if muted? || @current == file_name

    stop

    resource = @game.assets.get(file_name, Music.java_class)
    resource.setVolume(volume)
    resource.setLooping(loop)
    resource.play

    @current = file_name

    @game.log "playing music %s" % file_name
  end

  def stop
    return unless playing?

    @game.assets.get(@current, Music.java_class).stop
    @game.log "stopping current music"

    @current = nil
  end

  def dispose
    stop
  end

  private

  def playing?
    @current && @game.assets.isLoaded(@current, Music.java_class)
  end
end

