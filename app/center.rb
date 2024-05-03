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
    @button_list = []
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

    @button_list.each do |button|
      @game.outputs.primitives << button[:primitives]
    end

    button = button_clicked

    if button
      @button_list = []
      case button[:type]
      when :goto_space
        @game.state.board.space_selected(button[:meta][:space])
      end
    end
  end

  def configure_buttons_for_spaces(choices)
    @button_list = []
    start_row = Array(@game.state.messages).size + 1
    choices.each.with_index do |space_index, i|
      slide = @game.state.board.spaces[space_index].active_slide

      button(
        type: :goto_space,
        meta: { space: space_index },
        x: TEXT_START_X,
        y: TEXT_START_Y - ((i + start_row) * 50),
        text: slide.label
      )
    end
  end

  private

  def button(type:, x:, y:, text:, meta: {})
    @button_list << {
      type: type,
      meta: meta,
      primitives: [
        [x - 190, y, 380, 40, 12, 62, 131].solid, # background
        [x + 5 + Slide::TEXT_SHADOW_OFFSET, y + 30 - Slide::TEXT_SHADOW_OFFSET, text, 2, 1, *Slide::COLOR_FONT_SHADOW.values].label,
        [x + 5, y + 30, text, 2, 1, *Slide::COLOR_FONT.values].label
      ]
    }
  end

  # Finds the button that was clicked from the button list
  def button_clicked
    return nil unless @game.inputs.mouse.click

    click_pos = @game.inputs.mouse.click.point

    return @button_list.find { |button| click_pos.inside_rect?(button[:primitives].first.rect) }
  end
end
