require "app/support"

class BigBoard
  include Support
  STOP_DELAY = 20 # Frames

  attr_accessor :mode

  def initialize(game)
    @game = game
    @pattern = PATTERNS[rand(PATTERNS.size)]
    @pattern_index = 0
    @selected_space = nil
    @mode = "spin"
    configure_spaces
  end

  def tick
    send("tick_#{@mode}")
    @spaces.each(&:draw)
  end

  private

  def tick_stop
    @mode = "stopped" if tick_mod_hit?(STOP_DELAY)
  end

  def tick_stopped
    @spaces[@selected_space].flash_and_stop
  end

  def tick_spin
    @selected_space = @pattern[@pattern_index]

    @spaces.each(&:rotate_slide) if tick_mod_hit?(PANEL_ROTATION_TIME)

    if tick_mod_hit?(SPACE_BOUNCE_TIME)
      @spaces[@selected_space].active = false

      @pattern_index += 1
      if @pattern_index >= @pattern.size
        @pattern_index = 0
        @pattern = PATTERNS[rand(PATTERNS.size)]
      end
      @selected_space = @pattern[@pattern_index]

      @spaces[@selected_space].active = true
    end
  end

  def configure_spaces
    @spaces = []
    SPACE_POSITIONS.each do |index, data|
      if BOARD_LAYOUT[index]
        slides = BOARD_LAYOUT[index].map do |slide_hash|
          Object.const_get("Slide::#{slide_hash[:type]}").new(@game, **slide_hash.reject{ |k,v| k == :type })
        end
        @spaces << Space.new(@game, index: index, slides: slides, **data)
      end
    end
  end
end
