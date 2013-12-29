java_import com.badlogic.gdx.scenes.scene2d.ui.Skin
java_import com.badlogic.gdx.scenes.scene2d.ui.Table

class UIScreen < StageScreen
  def show
    super

    @skin = @game.assets.get(Settings::SKIN_PATH, Skin.class)
    @table = create_table
    @stage.addActor(@table)
  end

  protected

  def update(delta)
  end

  def draw(delta)
    super
    Table.drawDebug(@stage) if @game.preferences.developer?
  end

  private

  def crate_table
    table = Table.new(@skin)
    table.setFillParent(true)
    table.debug if @game.preferences.developer?
    table
  end
end
