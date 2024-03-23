require "app/constants/board_layouts"

require "app/big_board"
require "app/space"
require "app/slide"

require "app/slides/big_bucks"
require "app/slides/cash"
require "app/slides/cash_and_spin"
require "app/slides/jump_to_space"
require "app/slides/prize"
require "app/slides/pick_space"
require "app/slides/whammy"

BOARD_START_X = 200
BOARD_START_Y = 600

PANEL_ROTATION_TIME = 60 # Frames
SPACE_BOUNCE_TIME = 10 # Frames

PATTERNS = [
  [2, 15, 12, 9, 17, 7, 5, 13, 6, 4, 14, 10, 16, 1, 11, 0, 8, 3],
  [4, 17, 10, 12, 2, 5, 14, 6, 0, 8, 13, 15, 9, 1, 3, 11, 16, 7],
  [10, 5, 9, 11, 0, 3, 13, 15, 1, 8, 16, 7, 12, 14, 2, 6, 17, 4],
  [16, 9, 14, 12, 1, 7, 17, 15, 11, 2, 4, 10, 6, 3, 0, 8, 13, 5],
  [17, 15, 9, 4, 10, 8, 1, 12, 16, 6, 3, 14, 11, 7, 5, 2, 0, 13]
]

def tick(game)
  game.state.scene ||= "title"
  game.state.round = 0

  game.state.board ||= BigBoard.new(game)

  game.state.board.tick_spin

  game.state.board.draw
end

$gtk.reset
