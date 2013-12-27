class AudioManager
  def initialize(preferences, assets)
    @preferences, @assets = preferences, assets
  end

  [:muted?, :volume].each do |name|
    define_method(name) do
      prefix = self.class.name.gsub('Manager', '').downcase
      @preferences.send("#{prefix}_#{name}")
    end
  end
end
