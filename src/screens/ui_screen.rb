require 'stage_screen'

class UIScreen < StageScreen
  def show
    @skin = @game.assets.get(Settings::SKIN_PATH, Skin.java_class)
    @table = create_table
    @stage.addActor(@table)

    super()
  end

  protected

  def draw(delta)
    Table.drawDebug(@stage) if @game.preferences.developer?
    super
  end

  private

  def crate_table
    table = Table.new(@skin)
    table.setFillParent(true)
    table.debug if @game.preferences.developer?
    table
  end
end
