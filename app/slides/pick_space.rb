class Slide::PickSpace < Slide
  attr_reader :choices

  def draw_image
    @game.outputs.sprites << {
      x: @space.x + Space::LIGHT_WIDTH,
      y: @space.y + Space::LIGHT_WIDTH,
      w: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      h: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      path: "sprites/#{@image}"
    }
  end

  private

  def after_init_hook
    @background_color = { r: 8, g: 90, b: 57 }
  end
end
