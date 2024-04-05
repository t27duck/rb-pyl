class ResolveSpin
  def initialize(game:, space:)
    @game = game
    @space = space
    @slide = @space.active_slide
    @player = @game.state.players[@game.state.active_player]
  end

  def call
    @game.state.message = "Stopped on... #{@slide.text}"
    case @slide
    when Slide::Cash
      @player.score += @slide.cash_value
    when Slide::Prize
      @player.score += @slide.cash_value
    when Slide::CashAndSpin
      @player.score += @slide.cash_value
      @player.earned_spins += 1
    when Slide::Whammy
      @player.score = 0
      @player.whammies += 1
    end
  end

  def cleanup
    case @slide
    when Slide::Prize
      @slide.cycle_prize
    end
  end
end
