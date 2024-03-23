class Slide::Prize < Slide
  def text
    "A Prize"
  end

  def draw_label
    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET,
      text: "Prize",
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: -1
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2),
      text: "Prize",
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: -1
    }.merge(COLOR_FONT)
  end
end
