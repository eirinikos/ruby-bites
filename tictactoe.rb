class TTT
  attr_accessor :board

  # initialize the TTT board with nil values
  def initialize
    @board = Array.new(3) {Array.new(3)}
  end

  # print board in a human-readable format
  # instruct player 1 to make first move
  def print_board
    if @board.none? {|row| row.any? {|i| i }}
      puts "\n 1 | 2 | 3  \n-----------\n 4 | 5 | 6  \n-----------\n 7 | 8 | 9  \n\n"
      play_first_move 
    else
      puts "\n"
      @board.each do |row| 
        puts " #{row[0]} | #{row[1]} | #{row[2]} ",
        "-----------"
      end
      "#{}, the next move is yours! Select a move: \n"
    end
  end

  def play_first_move
    puts "Player 1, make your move!\nDo you want to play an X or an O?"
    player_1 = gets.chomp
    puts "Excellent choice. In which box would you like to place your #{player_1}?\n"
    player_1_place = gets.chomp
    # handle selection
  end

  def play_next_move
  end
end

# player 1 makes a move, get user input and update board
# player 2 makes a move, get user input and update board
# repeat until someone marks 3 Os or 3 Xs in a row (horizontal, vertical, or diagonal)

# horizontal victory for a given row = row[0] == row[1] == row[2]
# board.map{ |row| row.uniq.size == 1 }.any?

# vertical victory = (0..2).board
# diagonal victory = (0..2).

# display congratulatory message to the winning player
# OR, display proclamation of a draw