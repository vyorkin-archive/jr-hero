require 'initializer'

cfg = LwjglApplicationConfiguration.new

cfg.title = "JrHero"
cfg.useGL20 = true
cfg.width = 800
cfg.height = 640

LwjglApplication.new(JrHeroGame.new, cfg)
