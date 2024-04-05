class Slide::Cash < Slide
  def draw_image
    @game.outputs.sprites << {
      x: @space.x + Space::LIGHT_WIDTH,
      y: @space.y + Space::LIGHT_WIDTH,
      w: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      h: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      path: "sprites/coinstacks.png"
    }
  end

  def draw_label
    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET,
      text: "$#{@cash_value}",
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: 0
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2),
      text: "$#{@cash_value}",
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: 0
    }.merge(COLOR_FONT)
  end

  def text
    "$#{@cash_value}"
  end
end
