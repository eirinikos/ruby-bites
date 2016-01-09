class TTT
  attr_accessor :board

  def initialize
    @three_board = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
    @three_board_row_1 = @three_board[0]
    @three_board_row_2 = @three_board[1]
    @three_board_row_3 = @three_board[2]

    @four_board =  [[1, 2, 3, 4], [5, 6, 7, 8],
                      [9, 10, 11, 12], [13, 14, 15, 16]]
    @four_board_row_1 = @four_board[0]
    @four_board_row_2 = @four_board[1]
    @four_board_row_3 = @four_board[2]
    @four_board_row_4 = @four_board[3]
            
    @p1, @p2, @computer, @human, @turn, @board = nil
  end

  def print_three_board
    puts "\n #{@three_board_row_1[0]} | #{@three_board_row_1[1]} | #{@three_board_row_1[2]} ",
        "----------",
        " #{@three_board_row_2[0]} | #{@three_board_row_2[1]} | #{@three_board_row_2[2]} ",
        "----------",
        " #{@three_board_row_3[0]} | #{@three_board_row_3[1]} | #{@three_board_row_3[2]} "
  end

  def print_four_board
    puts "\n  #{@four_board_row_1[0]} |  #{@four_board_row_1[1]} | #{@four_board_row_1[2]}  | #{@four_board_row_1[3]} ",
        "-------------------",
        "  #{@four_board_row_2[0]} |  #{@four_board_row_2[1]} | #{@four_board_row_2[2]}  | #{@four_board_row_2[3]} ",
        "-------------------",
        "  #{@four_board_row_3[0]} | #{@four_board_row_3[1]} | #{@four_board_row_3[2]} | #{@four_board_row_3[3]} ",
        "-------------------",
        " #{@four_board_row_4[0]} | #{@four_board_row_4[1]} | #{@four_board_row_4[2]} | #{@four_board_row_4[3]} "
  end

  def update_three_board(player, place)
    case @place
    when 1, 2, 3
      if @three_board_row_1[place - 1].class == Fixnum
        @three_board_row_1[place - 1] = player
      else
        prompt_new_box(player)
      end
    when 4, 5, 6
      if @three_board_row_2[place - 4].class == Fixnum
        @three_board_row_2[place - 4] = player
      else
        prompt_new_box(player)
      end
    else
      if @three_board_row_3[place - 7].class == Fixnum
        @three_board_row_3[place - 7] = player
      else
        prompt_new_box(player)
      end
    end
    determine_game_over(player)
  end

  def update_four_board(player, place)
    case @place
    when 1, 2, 3, 4
      if @four_board_row_1[place - 1].class == Fixnum
        @four_board_row_1[place - 1] = player
      else
        prompt_new_box(player)
      end
    when 4, 5, 6, 7
      if @four_board_row_2[place - 4].class == Fixnum
        @four_board_row_2[place - 4] = player
      else
        prompt_new_box(player)
      end
    when 8, 9, 10, 11
      if @four_board_row_3[place - 8].class == Fixnum
        @four_board_row_3[place - 8] = player
      else
        prompt_new_box(player)
      end
    else
      if @four_board_row_4[place - 12].class == Fixnum
        @four_board_row_3[place - 12] = player
      else
        prompt_new_box(player)
      end
    end
    determine_game_over(player)
  end

  def display_menu
    # choose board size
    print "Would you like to play on a 3 x 3 board or a 4 x 4 board?\n"
    print "Enter '3' for the former or '4' for the latter: "
    @board = gets.chomp.to_i
    if @board == 3
      @board = @three_board
    elsif @board == 4
      @board = @four_board
    else
      @board = @three_board
      print "That's not a valid choice, so we'll just default to a 3 x 3 board.\n"
    end

    # choose whether to play against computer
    print "Would you like to play against the computer? (Y/N) "
    if ["Y","y"].include?(gets.chomp)
      print "Would you like to play first? (Y/N) "
      ["Y","y"].include?(gets.chomp) ? @computer = 0 : @computer = 1
      relay_computer_human_turns
    else
      relay_player_turns
    end
  end

  def computer_move  
    # sample of all available spaces within @board 
    @place = @board.flatten.select{ |i| i.class == Fixnum }.sample
    @board == @three_board ? update_three_board(@computer, @place) : update_four_board(@computer, @place)
  end

  def computer_think
    print "\nTHE ALMIGHTY COMPUTER IS CONTEMPLATING ITS MOVE...\n"
    3.times do
      sleep(1) # sleep for 1 second
      print "\nCOMPUTING...\n"
    end
    print "\nWHAM!\n"
    sleep(1)
  end

  def relay_computer_human_turns
    @board == @three_board ? print_three_board : print_four_board

    if @computer == 0 && @human.nil? # human plays first move of the game
      print "\nHuman, do you want to play an X or an O? "
      confirm_x_or_o
    elsif @computer == 1 # computer plays first move of the game
      @computer = ["X","O"].sample
      computer_move
    elsif @human.nil? # human plays second (human's first move)
      @computer == "O" ? @human = "X" : @human = "O"
      print "\nWatch out, Human! Computer has made its first move!"
      print "\nIn which box would you like to place your #{@human}? "
      mark(@human)
    elsif @computer == 0  # computer plays second (computer's first move)
      @human == "O" ? @computer = "X" : @computer = "O"
      computer_move
    elsif @turn == @human # human's subsequent move
      print "\nHuman, it's your move again - choose carefully where to place your #{@human}: "
      mark(@human)
    else # computer's subsequent move
      computer_move
    end
  end

  def relay_player_turns
    @board == @three_board ? print_three_board : print_four_board
    
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
    if @computer.nil?
      @p1 = gets.chomp
      player = @p1
    else
      @human = gets.chomp
      player = @human
    end

    if ["X","O","x","o"].include?(player)
      player.upcase!
      print "Excellent choice. In which box would you like to place your #{player}? "
      mark(player)
    else
      print "Sir / Madam, please choose X or O: "
      confirm_x_or_o
    end
  end

  def mark(player) 
    @place = gets.chomp.to_i
    if (1..9).include?(@place) ###### account for three_board or four_board
      update_board(player, @place)
    else
      print "Sir / Madam, please choose a valid number: "
      mark(player)
    end
  end

  def prompt_new_box(player)
    print_board ###### account for three_board or four_board
    print "\nSTOP in the name of the law! That box is occupied - please choose another one. "
    mark(player)
  end

  def determine_game_over(player)
    if victory?
      if @turn == @computer
        computer_think
      end

      print_board ###### account for three_board or four_board
      
      if @turn == @p1 || @turn == @p2 || @turn == @human
        puts "\nCONGRATULATIONS! You have vanquished your foe!\n\n(╯°□°)╯︵ ┻━┻\n\n"
      else
        puts "\nPUNY HUMAN, ACCEPT DEFEAT!"
      end
      restart_request
    elsif (@board.all?{|row| row.all? {|i| i.class == String} } && !victory?)      
      puts "Messieurs, mesdames - you have come to a draw."
      restart_request
    else
      if @computer.nil?
        player == @p1 ? @turn = @p2 : @turn = @p1
        relay_player_turns
      else
        player == @computer ? @turn = @human : @turn = @computer
        if @turn == @human
          computer_think
        end
        relay_computer_human_turns
      end
    end
  end

  def victory? ###### account for three_board or four_board
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
      display_menu
    end
  end
end

if __FILE__ == $0
  TTT.new.display_menu
end