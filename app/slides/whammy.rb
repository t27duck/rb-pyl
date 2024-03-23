class Slide::Whammy < Slide
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
    "A Whammy"
  end

  private

  def after_init_hook
    @background_color = { r: 255, g: 255, b: 153 }
  end
end
