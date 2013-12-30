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
    source = name.to_s
    key = source.gsub(/[!?=]/, '')
    target = target(source, key, args)

    define_singleton_method(name) do |*args|
      @storage.send(target, *[key, *args])
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

  private

  def target(name, key, args)
    return "get#{@map[key]}".to_sym unless name.end_with? '='

    arg = args.last

    ruby_type = arg.is_a?(Class) ? arg : arg.class
    @map[key] = name.end_with?('?') ? 'Boolean' : TYPE_MAPPINGS[ruby_type]

    "put#{@map[key]}".to_sym
  end
end
