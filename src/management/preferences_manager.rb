java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Preferences

class PreferencesManager
  TYPE_MAPPINGS = {
    TrueClass   => 'Boolean',
    FalseClass  => 'Boolean',
    Fixnum      => 'Integer',
    Integer     => 'Integer',
    Bignum      => 'Long',
    Float       => 'Float',
    String      => 'String'
  }

  def initialize(name)
    @storage = Gdx.app.getPreferences(name)
    @map = {}
  end

  def method_missing(name, *args, &block)
    source_name = name.to_s
    key = source_name.gsub(/[!?=]/, '')

    if source_name.end_with? '='
      arg = args.last

      ruby_type = arg.is_a?(Class) ? arg : arg.class
      java_type = source_name.end_with?('?') ? 'Boolean' : TYPE_MAPPINGS[ruby_type]
      @map[key] = java_type

      target_name = "put#{java_type}".to_sym
    else
      java_type = @map[key]
      target_name = "get#{java_type}".to_sym
    end

    define_singleton_method(name) do |*args|
      @storage.send(target_name, *[key, *args])
    end

    self.send(name, *args)
  end

  def respond_to_missing?(name, include_private = false)
    true
  end

  def include?(key)
    @storage.contains(key)
  end

  def clear
    @storage.clear
  end

  def delete(key)
    @storage.remove(key)
  end

  def save!
    @storage.flush
  end
end
