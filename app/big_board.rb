require "app/support"

class BigBoard
  include Support
  STOP_DELAY = 20 # Frames
  SLIDE_FLASH = 15 # Frames
  FLASHING_LIMIT = 5 * 2 # Handle on and off state

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
    if tick_mod_hit?(STOP_DELAY)
      @mode = "stopped"
      @flashing_complete = false
      @flash_count = 0
    end
  end

  def tick_stopped
    if !@flashing_complete
      if @flash_count > FLASHING_LIMIT
        @spaces[@selected_space].active = false
        @flashing_complete = true
      elsif tick_mod_hit?(SLIDE_FLASH)
        @spaces[@selected_space].toggle_active
        @flash_count += 1
      end
    end
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
