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
  # Space 1
  [
    {
      type: "Cash",
      cash_value: 350,
      color: "#435E95"
    },
    {
      type: "Whammy",
      image: "whammy-superhero.png"
    },
    {
      type: "PickSpace",
      text: "Move One Space",
      image: "moveonespace-corner.png",
      choices: [1, 17]
    }
  ],
  # Space 2
  [
    {
      type: "Cash",
      cash_value: 500,
      color: "#316384"
    },
    {
      type: "Cash",
      cash_value: 750,
      color: "#435E95"
    },
    {
      type: "Prize",
      color: "#54642D"
    }
  ],
  # Space 3
  [
    {
      type: "Cash",
      cash_value: 250,
      color: "#0C3E83"
    },
    {
      type: "Cash",
      cash_value: 400,
      color: "#316384"
    },
    {
      type: "Whammy",
      image: "whammy-jumping.png"
    }
  ],
  # Space 4
  [
    {
      type: "Cash",
      cash_value: 1000,
      color: "#316384"
    },
    {
      type: "Cash",
      cash_value: 1250,
      color: "#54642D"
    },
    {
      type: "Cash",
      cash_value: 1500,
      color: "#AF5C54"
    }
  ],
  # Space 5
  [
    {
      type: "Cash",
      cash_value: 300,
      color: "#AF5C54"
    },
    {
      type: "Prize",
      color: "#a73500"
    },
    {
      type: "Whammy",
      image: "whammy-hammer.png"
    }
  ],
  # Space 6
  [
    {
      type: "Cash",
      cash_value: 525,
      color: "#0C3E83"
    },
    {
      type: "Cash",
      cash_value: 650,
      color: "#D2DE4B"
    },
    {
      type: "JumpToSpace",
      target: 3,
      image: "backtwospaces.png",
      text: "Go Back Two Spaces"
    }
  ],
  # Space 7
  [
    {
      type: "Cash",
      cash_value: 470,
      color: "#435E95"
    },
    {
      type: "Prize",
      color: "#a73500"
    },
    {
      type: "Whammy",
      image: "whammy-leaning.png"
    }
  ],
  # Space 8
  [
    {
      type: "Cash",
      cash_value: 300,
      color: "#AF5C54"
    },
    {
      type: "Cash",
      cash_value: 450,
      color: "#54642D"
    },
    {
      type: "Cash",
      cash_value: 550,
      color: "#54642D"
    }
  ],
  # Space 9
  [
    {
      type: "Cash",
      cash_value: 350,
      color: "#435E95"
    },
    {
      type: "Cash",
      cash_value: 550,
      color: "#AF5C54"
    },
    {
      type: "Whammy",
      image: "whammy-running.png"
    }
  ],
  # Space 10
  [
    {
      type: "Cash",
      cash_value: 300,
      color: "#AF5C54"
    },
    {
      type: "CashAndSpin",
      cash_value: 500,
      color: "#D2DE4B"
    },
    {
      type: "Prize",
      color: "#a73500"
    }
  ],
  # Space 11
  [
    {
      type: "Cash",
      cash_value: 200,
      color: "#D2DE4B"
    },
    {
      type: "Cash",
      cash_value: 600,
      color: "#0C3E83"
    },
    {
      type: "JumpToSpace",
      target: 12,
      image: "advancetwospaces.png",
      text: "Advance Two Spaces"
    }
  ],
  # Space 12
  [
    {
      type: "Cash",
      cash_value: 400,
      color: "#316384"
    },
    {
      type: "BigBucks"
    },
    {
      type: "Whammy",
      image: "whammy-standing.png"
    }
  ],
  # Space 13
  [
    {
      type: "Cash",
      cash_value: 500,
      color: "#316384"
    },
    {
      type: "Cash",
      cash_value: 750,
      color: "#435E95"
    },
    {
      type: "Prize",
      color: "#AF5C54"
    }
  ],
  # Space 14
  [
    {
      type: "Cash",
      cash_value: 400,
      color: "#316384"
    },
    {
      type: "Cash",
      cash_value: 500,
      color: "#316384"
    },
    {
      type: "Whammy",
      image: "whammy-raisingarms.png"
    }
  ],
  # Space 15
  [
    {
      type: "Cash",
      cash_value: 550,
      color: "#AF5C54"
    },
    {
      type: "Cash",
      cash_value: 700,
      color: "#435E95"
    },
    {
      type: "Prize",
      color: "#54642D"
    }
  ],
  # Space 16
  [
    {
      type: "Cash",
      cash_value: 300,
      color: "#AF5C54"
    },
    {
      type: "Cash",
      cash_value: 500,
      color: "#316384"
    },
    {
      type: "Whammy",
      image: "whammy-taunting.png"
    }
  ],
  # Space 17
  [
    {
      type: "Cash",
      cash_value: 200,
      color: "#435E95"
    },
    {
      type: "Prize",
      color: "#a73500"
    },
    {
      type: "Whammy",
      image: "whammy-flex.png"
    }
  ],
  # Space 18
  [
    {
      type: "CashAndSpin",
      cash_value: 100,
      color: "#435E95"
    },
    {
      type: "CashAndSpin",
      cash_value: 200,
      color: "#A5C3F3"
    },
    {
      type: "CashAndSpin",
      cash_value: 300,
      color: "#54642D"
    }
  ]
]

def tick(game)
  game.state.scene ||= "title"
  game.state.round = 0

  game.state.board ||= BigBoard.new(game)

  game.state.board.tick_spin

  game.state.board.draw
end

$gtk.reset
