class BigBoard
  def initialize(game)
    @game = game
    @pattern = PATTERNS[rand(PATTERNS.size)]
    @pattern_index = 0
    @selected_space = nil
    configure_spaces
  end

  def draw
    @spaces.each(&:draw)
  end

  def tick_spin
    @selected_space = @pattern[@pattern_index]

    @spaces.each(&:rotate_slide) if @game.inputs.keyboard.key_down.space || @game.state.tick_count.mod_zero?(PANEL_ROTATION_TIME)

    if @game.state.tick_count.mod_zero?(SPACE_BOUNCE_TIME)
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
