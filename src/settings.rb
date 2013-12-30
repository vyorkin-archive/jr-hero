module Settings
  WIDTH             = 800
  HEIGHT            = 600
  TITLE             = 'JR Hero'
  VERSION           = '0.0.1 pre-alpha'
  LOG               = 'jr-hero'
  PREFERENCES       = TITLE.downcase.gsub(' ', '-')
  DEVELOPER         = true
  CURSOR_FILE_NAME  = nil
  GL20              = false
  ACCELEROMETER     = true
  COMPASS           = true
  WAKE_LOCK         = false
  HIDE_STATUS_BAR   = false
  VSYNC_ENABLED     = true
  FULLSCREEN        = false
  RESIZABLE         = true
  FORCE_EXIT        = true
  SKIN_PATH         = ''
  MUSIC_VOLUME      = 0.5
  SOUND_VOLUME      = 0.5
end
