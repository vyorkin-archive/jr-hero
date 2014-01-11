module R
  module Sound
    module Menu
      ENTER_CLICK = RELATIVE_ROOT + 'assets/sound/menu-enter-click.ogg'
      ENTER_HIT   = RELATIVE_ROOT + 'assets/sound/menu-enter-hit.ogg'
      EXIT        = RELATIVE_ROOT + 'assets/sound/menu-exit.ogg'
    end

    module Shot
      SINGLE      = RELATIVE_ROOT + 'assets/sound/single.wav'
    end

    module Hit
      ENEMY       = RELATIVE_ROOT + 'assets/sound/hit-enemy.ogg'
      PLAYER      = RELATIVE_ROOT + 'assets/sound/hit-player.ogg'
      SHIELD      = RELATIVE_ROOT + 'assets/sound/hit-shield.ogg'
    end

    module Explosion
      SHORT       = RELATIVE_ROOT + 'assets/sound/explosion-short.ogg'
      LONG        = RELATIVE_ROOT + 'assets/sound/explosion-long.ogg'
      BIG         = RELATIVE_ROOT + 'assets/sound/explosion-big.ogg'
    end
  end

  module Music
    LEVEL = RELATIVE_ROOT + 'assets/music/level.mp3'
  end

  module Font
    CONSOLAS = RELATIVE_ROOT + 'assets/font/consolas.fnt'
  end

  module Skin
    UI = RELATIVE_ROOT + 'assets/skin/ui.json'
  end

  module Texture
    BOMBER1 = RELATIVE_ROOT + 'assets/sprite/bomber1.png'
    BOMBER2 = RELATIVE_ROOT + 'assets/sprite/bomber2.png'
    BOMBER3 = RELATIVE_ROOT + 'assets/sprite/bomber3.png'
    BOMBER4 = RELATIVE_ROOT + 'assets/sprite/bomber4.png'

    FIGHTER1 = RELATIVE_ROOT + 'assets/sprite/fighter1.png'
    FIGHTER2 = RELATIVE_ROOT + 'assets/sprite/fighter2.png'
    FIGHTER3 = RELATIVE_ROOT + 'assets/sprite/fighter3.png'
    FIGHTER4 = RELATIVE_ROOT + 'assets/sprite/fighter4.png'
  end

  module Sprite
    module Enemy
      TRANSFORMER = 'enemy/transformer'
      RAPTOR      = 'enemy/raptor'
      RING        = 'enemy/ring'
      TANK        = 'enemy/tank'
      BUG         = 'enemy/bug'
      WORM        = 'enemy/worm'
      ALIEN       = 'enemy/alien'
      SUKHOI      = 'enemy/sukhoi'
    end

    module Explosion
      LARGE       = 'explosion/large'
      SMALL       = 'explosion/small'
    end

    module Shot
      SINGLE      = 'shot/single'
      DOUBLE      = 'shot/double'
      CIRCLE      = 'shot/circle'
    end

    module Ship
      GENCORE     = 'ship/gencore'
      CARROT      = 'ship/carrot'
      MICROCORP   = 'ship/microcorp'
      ARCADE      = 'ship/arcade'
      USP         = 'ship/usp'
    end
  end

  module Effect
  end

  module Atlas
    SHOOTER = RELATIVE_ROOT + 'assets/atlas/shooter.atlas'
  end
end
