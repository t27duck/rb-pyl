class Slide::JumpToSpace < Slide
  attr_reader :target

  def draw_image
    @game.outputs.sprites << {
      x: @space.x + Space::LIGHT_WIDTH,
      y: @space.y + Space::LIGHT_WIDTH,
      w: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      h: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      path: "sprites/#{@image}"
    }
  end

  def text
    "#{@text} to..."
  end

  private

  def after_init_hook
    @background_color = { r: 8, g: 90, b: 57 }
  end
end
