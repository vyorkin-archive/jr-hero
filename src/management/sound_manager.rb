require 'audio_manager'

class SoundManager < AudioManager
  def play(file_name)
    return if muted?

    sound = @game.assets.get(file_name, Sound.java_class)
    sound.play(volume)

    @game.log "playing sound %s" % file_name
  end
end
