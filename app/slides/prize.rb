class Slide::Prize < Slide
  FONT_SIZE = -3

  def text
    "#{@text} worth $#{@cash_value}"
  end

  def label
    @text
  end

  def draw_label
    send("draw_label#{@text_rows}")
  end

  def cycle_prize
    data = @game.state.prize_pool.pick
    @prefix = data[:prefix]
    @text = @prefix ? "#{@prefix} #{data[:text]}" : data[:text]
    @basic_text = data[:text]
    @cash_value = data[:value]
    setup_text_info
  end

  private

  def after_init_hook
    cycle_prize
  end

  def setup_text_info
    @text_array = @basic_text.split(" ")
    @text_array = [@text_array[0], @text_array[1], @text_array[2..].join(" ")] if @text_array.size > 3
    @text_rows = @text_array.size
  end

  def draw_label1
    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET,
      text: @text_array[0],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2),
      text: @text_array[0],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT)
  end

  def draw_label2
    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET + 12,
      text: @text_array[0],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2) + 12,
      text: @text_array[0],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET - 12,
      text: @text_array[1],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2) - 12,
      text: @text_array[1],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT)
  end

  def draw_label3
    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET + 20,
      text: @text_array[0],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2) + 20,
      text: @text_array[0],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET,
      text: @text_array[1],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2),
      text: @text_array[1],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2) + TEXT_SHADOW_OFFSET,
      y: @space.y + (Space::WIDTH / 2) - TEXT_SHADOW_OFFSET - 20,
      text: @text_array[2],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT_SHADOW)

    @game.outputs.labels << {
      x: @space.x + (Space::WIDTH / 2),
      y: @space.y + (Space::WIDTH / 2) - 20,
      text: @text_array[2],
      alignment_enum: 1,
      vertical_alignment_enum: 1,
      font: FONT,
      size_enum: FONT_SIZE
    }.merge(COLOR_FONT)
  end
end
