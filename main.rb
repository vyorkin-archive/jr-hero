require 'initializer'

cfg = LwjglApplicationConfiguration.new

cfg.title       = Settings::TITLE
cfg.useGL20     = Settings::GL20
cfg.width       = Settings::WIDTH
cfg.height      = Settings::HEIGHT
cfg.fullscreen  = Settings::FULLSCREEN

LwjglApplication.new(JrHeroGame.new, cfg)
