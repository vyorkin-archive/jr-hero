
class MusicManager < AudioManager
  def initialize(preferences, assets)
    @current = nil
    super
  end

  def play(file_name, loop = true)
    return if muted? || @current = file_name

    stop

    resource = @assets.get(file_name, Music.class)
    resource.setVolume(volume)
    resource.setLooping(loop)
    resource.play

    @current = file_name
  end

  def stop
    return unless playing?

    @assets.get(@current, Music.class).stop
    @current = nil
  end

  def dispose
    stop
  end

  private

  def playing?
    @current && @assets.isLoaded(@current, Music.class)
  end
end

