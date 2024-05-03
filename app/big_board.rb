require "app/support"

class BigBoard
  include Support
  STOP_DELAY = 20 # Frames
  SLIDE_FLASH = 15 # Frames
  SLICE_PICK_FLASH = 30 # Frame
  FLASHING_LIMIT = 4 * 2 # Handle on and off state

  attr_accessor :mode, :selected_space, :jumped_to_space
  attr_accessor :selectable_space, :selectable_spaces

  attr_reader :center, :spaces

  def initialize(game)
    @game = game
    @pattern = PATTERNS[rand(PATTERNS.size)]
    @pattern_index = 0
    @selected_space = nil
    @mode = "spin"
    @game.state.prize_pool = PrizePool.new(@game.state.round)
    @game.state.prize_pool.generate
    @jumped_to_space = false
    @center = Center.new(game)
    @selectable_spaces = []
    configure_spaces
  end

  def tick
    send("tick_#{@mode}")
    @spaces.each(&:draw)
    @center.draw
  end

  def space_selected(space_index)
    @selected_space = space_index
    @jumped_to_space = true
    process_stop
  end

  private

  def tick_stop
    process_stop if tick_mod_hit?(STOP_DELAY)
  end

  def process_stop
    @mode = "stopped"
    @flashing_complete = false
    @flash_count = 0
    @resolve_spin = ResolveSpin.new(game: @game, space: @spaces[@selected_space], board: self)
    @resolve_spin.call
    @center.mode = "text"
  end

  def tick_stopped
    return if @flashing_complete

    if @flash_count > FLASHING_LIMIT
      @spaces[@selected_space].active = false
      @flashing_complete = true
      @resolve_spin.cleanup
    elsif tick_mod_hit?(SLIDE_FLASH)
      @spaces[@selected_space].toggle_active
      @flash_count += 1
    end
  end

  def tick_spin
    @jumped_to_space = false
    @center.mode = "logo"
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

  def tick_select_space
    @selectable_space ||= @selectable_spaces[0]
    if tick_mod_hit?(SLICE_PICK_FLASH)
      @selectable_space = @selectable_spaces.rotate![0]
      @selectable_spaces.each do |index|
        @spaces[index].active = index == @selectable_space
      end
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
