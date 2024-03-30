class Player
  attr_accessor :earned_spins, :passed_spins, :whammies, :score, :index

  def initialize(index:)
    @index = index
    @earned_spins = 0
    @passed_spins = 0
    @whammies = 0
    @score = 0
  end
end
