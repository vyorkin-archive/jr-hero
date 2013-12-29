class SoundManager < AudioManager
  def play(file_name)
    @assets.get(file_name, Sound.class).play(volume) unless muted?
  end
end
