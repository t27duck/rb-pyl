class ResolveSpin
  def initialize(game:, space:, board:)
    @game = game
    @space = space
    @slide = @space.active_slide
    @player = @game.state.players[@game.state.active_player]
    @board = board
  end

  def call
    if @board.jumped_to_space
      @game.state.messages = @slide.text
    else
      @game.state.messages = ["Stopped on...", @slide.text]
    end
    case @slide
    when Slide::Cash
      @player.score += @slide.cash_value
      @board.mode = "stopped"
    when Slide::Prize
      @player.score += @slide.cash_value
      @board.mode = "stopped"
    when Slide::CashAndSpin
      @player.score += @slide.cash_value
      @player.earned_spins += 1
      @board.mode = "stopped"
    when Slide::Whammy
      @player.score = 0
      @player.whammies += 1
      @board.mode = "stopped"
    when Slide::PickSpace
      @board.mode = "select_space"
      @board.selectable_space = nil
      @board.selectable_spaces = @slide.choices
    end
  end

  def cleanup
    @board.jumped_to_space = false
    case @slide
    when Slide::Prize
      @slide.cycle_prize
    when Slide::JumpToSpace
      @board.mode = "stop"
      @board.selected_space = @slide.target
      @board.jumped_to_space = true
    end
  end
end
