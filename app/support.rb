module Support
  def tick_mod_hit?(frame_limit)
    @game.state.tick_count.mod_zero?(frame_limit)
  end
end
