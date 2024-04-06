BOARD_START_X = 200
BOARD_START_Y = 600

SPACE_BOUNCE_TIME = 20 # Frames
PANEL_ROTATION_TIME = SPACE_BOUNCE_TIME * 3 # Frames

PATTERNS = [
  [2, 15, 12, 9, 17, 7, 5, 13, 6, 4, 14, 10, 16, 1, 11, 0, 8, 3],
  [4, 17, 10, 12, 2, 5, 14, 6, 0, 8, 13, 15, 9, 1, 3, 11, 16, 7],
  [10, 5, 9, 11, 0, 3, 13, 15, 1, 8, 16, 7, 12, 14, 2, 6, 17, 4],
  [16, 9, 14, 12, 1, 7, 17, 15, 11, 2, 4, 10, 6, 3, 0, 8, 13, 5],
  [17, 15, 9, 4, 10, 8, 1, 12, 16, 6, 3, 14, 11, 7, 5, 2, 0, 13]
]

require "app/big_board"
require "app/player"
require "app/prize_pool"
require "app/resolve_spin"
require "app/space"
require "app/slide"

require "app/slides/cash"
require "app/slides/cash_and_spin"
require "app/slides/jump_to_space"
require "app/slides/big_bucks"
require "app/slides/prize"
require "app/slides/pick_space"
require "app/slides/whammy"

require "app/constants/board_layouts"
require "app/constants/prizes"

def tick(game)
  game.state.scene ||= "title"
  game.state.round = 0

  game.state.board ||= BigBoard.new(game)
  game.state.players ||= [Player.new(index: 0)]
  game.state.active_player ||= 0

  if game.inputs.keyboard.key_down.space
    if game.state.board.mode == "stopped"
      game.state.board.mode = "spin"
    else
      game.state.board.mode = "stop"
    end
  end

  game.state.board.tick

  game.state.message ||= ""
  game.outputs.labels << {x: 10, y: 140, text: "Score: #{game.state.players[game.state.active_player].score}", alignment_enum: 0}
  game.outputs.labels << {x: 10, y: 120, text: "Earned: #{game.state.players[game.state.active_player].earned_spins}", alignment_enum: 0}
  game.outputs.labels << {x: 10, y: 100, text: "Passed: #{game.state.players[game.state.active_player].passed_spins}", alignment_enum: 0}
  game.outputs.labels << {x: 10, y: 80, text: "Whammies: #{game.state.players[game.state.active_player].whammies}", alignment_enum: 0}
  game.outputs.labels << {x: 10, y: 60, text: "Message: #{game.state.message}", alignment_enum: 0}
end

$gtk.reset
