java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Preferences

class PreferencesManager
  {
    :sound => 0.5,
    :music => 0.5
  }.each do |group, default|
    key  = "#{group}.volume"
    name = "#{group}_volume"

    define_method(name.to_sym) do
      load.getFloat(key, default)
    end

    define_method("#{name}=".to_sym) do |volume|
      load.putFloat(key, volume)
      save!
    end

    define_method("#{group}_muted?".to_sym) do
      load.getBoolean("#{group}.muted", false)
    end
  end

  def developer?
    load.getBoolean("developer", Settings::DEVELOPER)
  end

  def save!
    load.flush
  end

  private

  def load
    Gdx.app.getPreferences(Settings::PREFERENCES)
  end
end
