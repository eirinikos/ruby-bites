require "minitest/autorun"
require_relative "tictactoe"

class TestTTT < Minitest::Test
  def setup   
  end

  def test_that_players_token_is_placed_on_board
    ttt = TTT.new
    
    ttt.relay_turns
   
    # user input: x 1 2 3 4 5 6 8 7 9 n

    board = ttt.board

    assert_equal board[0][0], "X"
    assert_equal board[0][1], "O"
    assert_equal board[0][2], "X"
    assert_equal board[1][0], "O"
    assert_equal board[1][1], "X"
    assert_equal board[1][2], "O"
    assert_equal board[2][0], "O"
    assert_equal board[2][1], "X"
    assert_equal board[2][2], "X"
  end
end