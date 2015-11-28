# initialize the board with nil values
board = Array.new(3) {Array.new(3)}

# print board in a human-readable format
# instruct player 1 to make first move
def print_board(board)
  if board.none? {|row| row.any? {|i| i }}
    puts "\n   |   |    \n-----------\n   |   |    \n-----------\n   |   |    \n\n"
    "Player 1, make your move!"
  else
    puts "\n"
    board.each do |row| 
      puts " #{row[0]} | #{row[1]} | #{row[2]} ",
      "-----------"
    end
    "Next move!"
  end
end


# player 1 makes a move, get user input and update matrix
# player 2 makes a move, get user input and update matrix
# repeat until someone marks 3 Os or 3 Xs in a row (horizontal, vertical, or diagonal)

# horizontal victory for a given row = row[0] == row[1] == row[2]
# board.map{ |row| row.uniq.size == 1 }.any?

# vertical victory = (0..2).board
# diagonal victory = (0..2).

# display congratulatory message to the winning player
# OR, display proclamation of a draw