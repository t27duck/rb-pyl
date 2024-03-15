require "app/space"
require "app/slide"

require "app/slides/cash"
require "app/slides/whammy"

BOARD_START_X = 500
BOARD_START_Y = 500

SPACE_POSITIONS = {}.tap do |hash|
  6.times do |i|
    hash[i] = {
      x: BOARD_START_X + (i * Space::WIDTH),
      y: BOARD_START_Y,
    }
  end
  3.times do |i|
    hash[i + 6] = {
      x: BOARD_START_X + (5 * Space::WIDTH),
      y: BOARD_START_Y - ((i + 1) * Space::WIDTH),
    }
  end
  6.times do |i|
    hash[i + 9] = {
      x: BOARD_START_X + (5 * Space::WIDTH) - (i * Space::WIDTH),
      y: BOARD_START_Y - (4 * Space::WIDTH),
    }
  end
  3.times do |i|
    hash[i + 15] = {
      x: BOARD_START_X,
      y: BOARD_START_Y + ((i + 1) * Space::WIDTH) - (4 * Space::WIDTH),
    }
  end
end

BOARD_LAYOUT = [
  [ # Space 0
    {
      "Cash" => {
        cash_value: 350,
        color: { r: 67, g: 94, b: 149 }
      }
    },
    {
      "Whammy" => {
        image: "whammy-superhero.png"
      }
    },
    {
      "PickSpace" => {
        text: "Move One Space",
        image: "moveonespace-corner.png",
        choices: [1, 17]
      }
    }
  ]
]

def tick(game)
  game.state.scene ||= "title"

  game.state.board ||= build_board(game)

  game.state.board.each(&:draw)
end

def build_board(game)
  board = []
  SPACE_POSITIONS.each do |index, data|
    board << Space.new(
      game,
      index: index,
      slides: [Slide::Cash.new(game, cash_value: index)],
      **data
    )
  end
  board
end

$gtk.reset
