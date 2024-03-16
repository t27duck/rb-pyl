class Space
  attr_accessor :active
  attr_reader :x, :y

  LIGHT_WIDTH = 10
  WIDTH = 100 + LIGHT_WIDTH

  COLOR_LIGHT_OFF = { r: 0, g: 0, b: 0 }
  COLOR_LIGHT_ON = { r: 255, g: 255, b: 255 }

  def initialize(game, index:, x:, y:, active_index: 0, slides: [])
    @index = index
    @game = game
    @slides = slides
    @active = false
    @active_index = rand(3)
    @x = x
    @y = y
    @slides.each do |slide|
      slide.space = self
    end
  end

  def draw
    @game.outputs.solids << {
      x: @x,
      y: @y,
      w: WIDTH,
      h: WIDTH,
    }.merge(@active ? COLOR_LIGHT_ON : COLOR_LIGHT_OFF)

    @slides[@active_index].draw
  end

  def rotate_slide
    loop do
      new_index = rand(3)
      if new_index != @active_index
        @active_index = new_index
        break
      end
    end
  end
end
