class TTT
  def initialize
    @three_board = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
    @flat_3_board = @three_board.flatten

    @four_board =  [[1, 2, 3, 4], [5, 6, 7, 8],
                      [9, 10, 11, 12], [13, 14, 15, 16]]
    @flat_4_board = @four_board.flatten
            
    @p1, @p2, @computer, @human, @turn, @choice = nil
    @board = @three_board
  end

  def print_three_board
    puts "\n #{@flat_3_board[0]} | #{@flat_3_board[1]} | #{@flat_3_board[2]} ",
        "----------",
        " #{@flat_3_board[3]} | #{@flat_3_board[4]} | #{@flat_3_board[5]} ",
        "----------",
        " #{@flat_3_board[6]} | #{@flat_3_board[7]} | #{@flat_3_board[8]} "
  end

  def print_four_board
    puts "\n  #{@flat_4_board[0]} |  #{@flat_4_board[1]} | #{@flat_4_board[2]}  | #{@flat_4_board[3]} ",
        "-------------------",
        "  #{@flat_4_board[4]} |  #{@flat_4_board[5]} | #{@flat_4_board[6]}  | #{@flat_4_board[7]} ",
        "-------------------",
        "  #{@flat_4_board[8]} | #{@flat_4_board[9]} | #{@flat_4_board[10]} | #{@flat_4_board[11]} ",
        "-------------------",
        " #{@flat_4_board[12]} | #{@flat_4_board[13]} | #{@flat_4_board[14]} | #{@flat_4_board[15]} "
  end

  def update_three_board(player, place)
    if @flat_3_board[place - 1].class == Fixnum
      @flat_3_board[place - 1] = player
      @board = @flat_3_board.each_slice(@choice).to_a
    else
      prompt_new_box(player)
    end

    determine_game_over(player)
  end

  def update_four_board(player, place)
    if @flat_4_board[place - 1].class == Fixnum
      @flat_4_board[place - 1] = player
      @board = @flat_4_board.each_slice(@choice).to_a
    else
      prompt_new_box(player)
    end

    determine_game_over(player)
  end

  def display_menu
    # choose board size
    print "Would you like to play on a 3 x 3 board or a 4 x 4 board?\n"
    print "Enter '3' for the former or '4' for the latter: "
    @choice = gets.chomp.to_i
    if @choice == 4
      @board = @four_board
    elsif @choice != 3 && @choice != 4
      @choice == 3
      print "That's not a valid choice, so we'll just default to a 3 x 3 board.\n"
    end

    # choose whether to play against computer
    print "Would you like to play against the computer? (Y/N) "
    if ["Y","y"].include?(gets.chomp)
      print "Would you like to play first? (Y/N) "
      ["Y","y"].include?(gets.chomp) ? @computer = 0 : @computer = 1
      relay_computer_human_turns
    else
      print "OK, let's proceed with two human players...\n"
      relay_player_turns
    end
  end

  def computer_move  
    # sample of all available spaces within @board 
    @place = @board.flatten.select{ |i| i.class == Fixnum }.sample
    @choice == 3 ? update_three_board(@computer, @place) : update_four_board(@computer, @place)
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
    @choice == 3 ? print_three_board : print_four_board

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
    @choice == 3 ? print_three_board : print_four_board
    
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
    if (@choice == 3 && (1..9).include?(@place)) ||
      (@choice == 4 && (1..16).include?(@place))
      @choice == 3 ? update_three_board(player, @place) :
      update_four_board(player, @place)
    else
      print "Sir / Madam, please choose a valid number: "
      mark(player)
    end
  end

  def prompt_new_box(player)
    @choice == 3 ? print_three_board : print_four_board
    print "\nSTOP in the name of the law! That box is occupied - please choose another one. "
    mark(player)
  end

  def determine_game_over(player)
    if victory?
      if @turn == @computer
        computer_think
      end

      @choice == 3 ? print_three_board : print_four_board
      
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

  def victory?
    reverse_board = @board.map{ |a| a.reverse }
    @board.any?{ |row| row.uniq.size == 1 } ||
    @board.transpose.any?{ |row| row.uniq.size == 1 } ||
    (@choice == 3 && (0..2).map{ |i| @board[i][i] }.uniq.size == 1) ||
    (@choice == 3 && (0..2).map{ |i| reverse_board[i][i] }.uniq.size == 1) ||

    (@choice == 4 && (0..3).map{ |i| @board[i][i] }.uniq.size == 1) ||
    (@choice == 4 && (0..3).map{ |i| reverse_board[i][i] }.uniq.size == 1)  
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