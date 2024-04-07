class Center
  X = BOARD_START_X + Space::WIDTH
  Y = BOARD_START_Y - (Space::WIDTH * 3)
  TEXT_START_X = ((X + Space::WIDTH * 4) / 1.40)
  TEXT_START_Y = Y + (Space::WIDTH * 3) - 20
  LOGO_X = X
  LOGO_Y = Y
  WIDTH = Space::WIDTH * 4
  HEIGHT = Space::WIDTH * 3
  COLOR_BG = { r: 0, g: 0, b: 255 }

  attr_accessor :mode

  def initialize(game)
    @game = game
    @mode = "logo"
  end

  def draw
    if @mode == "logo"
        @game.outputs.sprites << {
          x: LOGO_X,
          y: LOGO_Y,
          w: WIDTH,
          h: HEIGHT,
          path: "sprites/logo.png"
        }
      return
    end

    @game.outputs.solids << {
      x: X,
      y: Y,
      w: WIDTH,
      h: HEIGHT,
    }.merge(COLOR_BG)

    Array(@game.state.messages).each.with_index do |message, i|
      @game.outputs.labels << {
        x: TEXT_START_X + Slide::TEXT_SHADOW_OFFSET,
        y: Y + (Space::WIDTH * 3) - 20 - Slide::TEXT_SHADOW_OFFSET - (i * 30),
        text: message,
        alignment_enum: 1,
        vertical_alignment_enum: 1.2,
        font: Slide::FONT,
        size_enum: 0
      }.merge(Slide::COLOR_FONT_SHADOW)

      @game.outputs.labels << {
        x: TEXT_START_X,
        y: TEXT_START_Y - (i * 30),
        text: message,
        alignment_enum: 1,
        vertical_alignment_enum: 1,
        font: Slide::FONT,
        size_enum: 0
      }.merge(Slide::COLOR_FONT)
    end
  end
end
