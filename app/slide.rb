class Slide
  attr_accessor :space

  COLOR_BG_BLUE = { r: 0, g: 0, b: 255 }
  COLOR_FONT = { r: 255, g: 255, b: 255 }
  COLOR_FONT_SHADOW = { r: 0, g: 0, b: 0 }

  FONT = "fonts/Franklin Gothic Condensed.ttf"

  TEXT_SHADOW_OFFSET = 2

  def initialize(game, cash_value: 0, color: { r: 67, g: 94, b: 149 }, image: nil, text: nil, target: nil, choices: [])
    @game = game
    @cash_value = cash_value
    @image = image
    @background_color = determine_background_color(color)
    @text = text
    @choices = []
    @target = target
    after_init_hook
  end

  def draw
    @game.outputs.solids << {
      x: @space.x + Space::LIGHT_WIDTH,
      y: @space.y + Space::LIGHT_WIDTH,
      w: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
      h: Space::WIDTH - (Space::LIGHT_WIDTH * 2),
    }.merge(@background_color)

    draw_image
    draw_label
  end

  def draw_image
  end

  def draw_label
  end

  def text
    @text || "NAME NOT FOUND"
  end

  private

  def after_init_hook
  end

  def determine_background_color(color)
    return color if color.is_a?(Hash)

    parts = color.split("")

    r = parts[1] + parts[2]
    g = parts[3] + parts[3]
    b = parts[5] + parts[6]

    [:r, :g, :b].zip([r, g, b].map(&:hex)).to_h
  end
end
