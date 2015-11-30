class TTT
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
    @row_1 = @board[0]
    @row_2 = @board[1]
    @row_3 = @board[2]
  end

  def print_board
    puts "\n #{@row_1[0]} | #{@row_1[1]} | #{@row_1[2]} ",
        "----------",
        " #{@row_2[0]} | #{@row_2[1]} | #{@row_2[2]} ",
        "----------",
        " #{@row_3[0]} | #{@row_3[1]} | #{@row_3[2]} "
  end

  def update_board(player, place)
    error_msg = "\nSTOP in the name of the law! That box is occupied - please choose another one. "
    case @place
    when 1, 2, 3
      if @row_1[place - 1].class == Fixnum
        @row_1[place - 1] = player
      else
        print_board
        print error_msg
        player_move(player)
      end
    when 4, 5, 6
      if @row_2[place - 4].class == Fixnum
        @row_2[place - 4] = player
      else
        print_board
        print error_msg
        player_move(player)
      end
    else
      if @row_3[place - 7].class == Fixnum
        @row_3[place - 7] = player
      else
        print_board
        print error_msg
        player_move(player)
      end
    end
    player == @p1 ? @turn = @p2 : @turn = @p1
    turns
  end

  def turns
    print_board
    if @p1.nil?  
      print "\nPlayer 1, make your move!\nDo you want to play an X or an O? "
      @p1 = gets.chomp
      print "Excellent choice. In which box would you like to place your #{@p1}? "
      player_move(@p1)
    elsif @p2.nil?
      @p1 == "O" ? @p2 = "X" : @p2 = "O"
      print "\nPlayer 2, make your move! In which box would you like to place your #{@p2}? "
      player_move(@p2)
    elsif @turn == @p1
      print "\nPlayer 1, back to you! In which box would you like to place your #{@p1}? "
      player_move(@p1)
    else
      print "\nPlayer 2, back to you! In which box would you like to place your #{@p2}? "
      player_move(@p2)
    end
  end

  def player_move(player) 
    @place = gets.chomp.to_i
    update_board(player, @place)
  end
end

# step 1: create a new gameboard instance (b = TTT.new)
# step 2: prompt the next player to take a turn (b.turns)

# repeat until someone marks 3 Os or 3 Xs in a row (horizontal, vertical, or diagonal)
# identify the winning player

# horizontal victory: @board.map{ |row| row.uniq.size == 1 }.any?
# vertical victory: @board.transpose.map{ |row| row.uniq.size == 1 }.any?
# diagonal victory: (0..2).

# display congratulatory message to the winning player
# OR, display proclamation of a draw