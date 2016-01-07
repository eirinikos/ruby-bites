class TTT
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
    @row_1 = @board[0]
    @row_2 = @board[1]
    @row_3 = @board[2]
    @p1, @p2 = nil
  end

  def print_board
    puts "\n #{@row_1[0]} | #{@row_1[1]} | #{@row_1[2]} ",
        "----------",
        " #{@row_2[0]} | #{@row_2[1]} | #{@row_2[2]} ",
        "----------",
        " #{@row_3[0]} | #{@row_3[1]} | #{@row_3[2]} "
  end

  def update_board(player, place)
    case @place
    when 1, 2, 3
      if @row_1[place - 1].class == Fixnum
        @row_1[place - 1] = player
      else
        prompt_new_box(player)
      end
    when 4, 5, 6
      if @row_2[place - 4].class == Fixnum
        @row_2[place - 4] = player
      else
        prompt_new_box(player)
      end
    else
      if @row_3[place - 7].class == Fixnum
        @row_3[place - 7] = player
      else
        prompt_new_box(player)
      end
    end
    determine_game_over(player)
  end

  def display_menu
    print "Would you like to play against the computer? (Y/N) "
    if ["Y","y"].include?(gets.chomp)
      print "Would you like to play first? (Y/N) "
      ["Y","y"].include?(gets.chomp) ? relay_turns : computer_move ### account for computer's turn
    else
      @computer = nil
      relay_turns
    end
  end

  def computer_move
    @computer = ["X","O"].sample
    @place = @board.flatten.select{ |i| i.class == Fixnum }.sample
    # sample of all available spaces within @board

    update_board(@computer, @place)
    print "Watch out, Human! Computer has made its first move!"
    # computer decides where to play X or O; display board
  end

  def relay_turns
    print_board
    if @p1.nil?
      print "\nPlayer 1, make your move!\nDo you want to play an X or an O? "
      confirm_x_or_o
    elsif @p2.nil?
      @p1 == "O" ? @p2 = "X" : @p2 = "O"
      print "\nPlayer 2, make your move! In which box would you like to place your #{@p2}? "
      mark(@p2)
    elsif @turn == @p1
      print "\nPlayer 1, back to you! In which box would you like to place your #{@p1}? "
      mark(@p1)
    else
      print "\nPlayer 2, back to you! In which box would you like to place your #{@p2}? "
      mark(@p2)
    end
  end

  def confirm_x_or_o
    @p1 = gets.chomp
    if ["X","O","x","o"].include?(@p1)
      @p1.upcase!
      print "Excellent choice. In which box would you like to place your #{@p1}? "
      mark(@p1)
    else
      print "Sir / Madam, please choose X or O: "
      confirm_x_or_o
    end
  end

  def mark(player) 
    @place = gets.chomp.to_i
    if (1..9).include?(@place)
      update_board(player, @place)
    else
      print "Sir / Madam, please choose a valid number: "
      mark(player)
    end
  end

  def prompt_new_box(player)
    print_board
    print "\nSTOP in the name of the law! That box is occupied - please choose another one. "
    mark(player)
  end

  def determine_game_over(player)
    if victory?
      print_board
      puts "\nCONGRATULATIONS! You have vanquished your foe!\n\n(╯°□°)╯︵ ┻━┻\n\n"
      restart_request
    elsif (@board.all?{|row| row.all? {|i| i.class == String} } && !victory?)
      puts "Messieurs, mesdames - you have come to a draw."
      restart_request
    else
      if @computer.nil?
        player == @p1 ? @turn = @p2 : @turn = @p1
      else
        player == @computer ? @turn = @human : @turn = @computer
      end
      relay_turns
    end
  end

  def victory?
    reverse_board = @board.map{ |a| a.reverse }
    @board.any?{ |row| row.uniq.size == 1 } ||
    @board.transpose.any?{ |row| row.uniq.size == 1 } ||
    (0..2).map{ |i| @board[i][i] }.uniq.size == 1 ||
    (0..2).map{ |i| reverse_board[i][i] }.uniq.size == 1
  end

  def restart_request
    print "Would you like to play again? (Y/N) "
    if ["Y","y"].include?(gets.chomp)
      initialize
      relay_turns
    end
  end
end

if __FILE__ == $0
  TTT.new.relay_turns
end