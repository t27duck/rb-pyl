class Slide::Prize < Slide
  def text
    "#{@text} worth $#{@cash_value}"
  end

  def label
    @text
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

  def cycle_prize
    data = @game.state.prize_pool.pick
    @prefix = data[:prefix]
    @text = @prefix ? "#{@prefix} #{data[:text]}" : data[:text]
    @cash_value = data[:value]
  end

  private

  def after_init_hook
    cycle_prize
  end
end
