class PrizePool
  attr_accessor :round

  def initialize(round)
    @working_pool = []
    @round = round
  end

  def generate
    @working_pool = PRIZES[@round].shuffle
  end

  def pick
    generate if @working_pool.size == 0

    @working_pool.pop
  end
end
