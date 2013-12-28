java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.graphics.g2d.BitmapFont.TextBounds
java_import com.badlogic.gdx.math.Vector2

module FontUtils
  def initialize
    @font = BitmapFont.new
  end

  def draw_center(text)
    draw(text, Gdx.graphics.getWidth / 2.0, Gdx.graphics.getHeight / 2.0)
  end

  def draw(text, x, y)
    bounds = @font.getBounds(text)
    @font.draw(
  end

  public static void drawCenter(String val) {
		draw(val, Gdx.graphics.getWidth() / 2, Gdx.graphics.getHeight() / 2);
	}
	
	public static void draw(String val, Vector2 pos) {
		draw(val, pos.x, pos.y);
	}
	
	public static void draw(String val, float x, float y) {
		TextBounds numberBounds = E.font.getBounds(val);
		
		float cx = x - numberBounds.width / 2;
		float cy = y - numberBounds.height / 2;
		
		E.font.draw(E.batch, val, cx, cy);
	}
	
	public static void draw(int val, Vector2 pos) {
		draw(Integer.toString(val), pos);
	}
end
