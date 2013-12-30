class AudioManager
  def initialize(game)
    @game = game
  end

  [:muted?, :volume].each do |name|
    define_method(name) do
      prefix = self.class.name.gsub('Manager', '').downcase
      postfix = name.to_s.gsub('?', '')
      @game.preferences.send("#{prefix}_#{postfix}".to_sym)
    end
  end
end
