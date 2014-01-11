class HUDRenderer < Renderer
  def render(delta)
    player_ship = @game.entities.tagged(:player, :ship).first
    font.draw(batch, "Fuel: %d" % player_ship.fuel.remaining, 8, 120)
    font.draw(batch, "Ammo: %d" % player_ship.cannon.ammo, 8, 140)
  end
end
