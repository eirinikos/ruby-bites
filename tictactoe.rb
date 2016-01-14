class TTT
  def initialize            
    @player_1, @player_2, @computer, @human, @turn, @dimension, @board = nil
  end

  def print_board
    if @dimension == 3
      puts "\n #{@board[0]} | #{@board[1]} | #{@board[2]} ",
          "----------",
          " #{@board[3]} | #{@board[4]} | #{@board[5]} ",
          "----------",
          " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    else
      puts "\n  #{@board[0]} |  #{@board[1]} |  #{@board[2]} |  #{@board[3]}",
          "-------------------",
          "  #{@board[4]} |  #{@board[5]} |  #{@board[6]} |  #{@board[7]}",
          "-------------------",
          "  #{@board[8]} | #{@board[9]} | #{@board[10]} | #{@board[11]} ",
          "-------------------",
          " #{@board[12]} | #{@board[13]} | #{@board[14]} | #{@board[15]} "
    end
  end

  def available?(box)
    box.to_i != 0
  end

  def update_board(player, place)
    if available?(@board[place - 1])
      @board[place - 1] = player.rjust(place.to_s.length)
    else
      prompt_new_box(player)
    end
    determine_game_over(player)
  end

  def yes?
    ["Y","y"].include?(gets.chomp)
  end

  def display_menu
    print "Would you like to play on a 3 x 3 board or a 4 x 4 board?\n"
    print "Enter '3' for the former or '4' for the latter: "
    @dimension = gets.chomp.to_i
    if @dimension == 3
      @board = %w{1 2 3 4 5 6 7 8 9}
    elsif @dimension == 4
      @board = %w{1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16}
    else
      @dimension = 3
      @board = %w{1 2 3 4 5 6 7 8 9}
      print "That's not a valid choice, so we'll just default to a 3 x 3 board.\n"
    end

    print "Would you like to play against the computer? (Y/N) "
    if yes?
      print "Would you like to play first? (Y/N) "
      yes? ? @computer = 0 : @computer = 1
      relay_computer_human_turns
    else
      print "OK, let's proceed with two human players...\n"
      relay_player_turns
    end
  end

  def computer_move  
    computer_think
    # sample of all available spaces within @board 
    @place = @board.flatten.select{ |i| available?(i) }.sample
    update_board(@computer, @place)
  end

  def computer_think
    print "\nTHE ALMIGHTY COMPUTER IS CONTEMPLATING ITS MOVE...\n"
    3.times do
      sleep(1)
      print "\nCOMPUTING...\n"
    end
    print "\nWHAM!\n"
    sleep(1)
  end

  def relay_computer_human_turns
    print_board

    if @computer == 0 && @human.nil? # human plays first move of the game
      print "\nHuman, do you want to play an X or an O? "
      confirm_x_or_o
    elsif @computer == 1 # computer plays first move of the game
      @computer = ["X","O"].sample
      computer_move
    elsif @human.nil? # human plays second (this is human's first move)
      @computer == "O" ? @human = "X" : @human = "O"
      print "\nWatch out, Human! Computer has made its first move!"
      print "\nIn which box would you like to place your #{@human}? "
      mark(@human)
    elsif @computer == 0  # computer plays second (this is computer's first move)
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
    print_board
    
    if @player_1.nil?
      print "\nPlayer 1, make your move!\nDo you want to play an X or an O? "
      confirm_x_or_o
    elsif @player_2.nil?
      @player_1 == "O" ? @player_2 = "X" : @player_2 = "O"
      print "\nPlayer 2, make your move! In which box would you like to place your #{@player_2}? "
      mark(@player_2)
    elsif @turn == @player_1
      print "\nPlayer 1, back to you! In which box would you like to place your #{@player_1}? "
      mark(@player_1)
    else
      print "\nPlayer 2, back to you! In which box would you like to place your #{@player_2}? "
      mark(@player_2)
    end
  end

  def confirm_x_or_o
    if @computer.nil?
      @player_1 = gets.chomp
      player = @player_1
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
    if (@dimension == 3 && (1..9).include?(@place)) ||
      (@dimension == 4 && (1..16).include?(@place))
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
      
      if @turn == @player_1 || @turn == @player_2 || @turn == @human
        puts "\nCONGRATULATIONS! You have vanquished your foe!\n\n(╯°□°)╯︵ ┻━┻\n\n"
      else
        puts "\nPUNY HUMAN, ACCEPT DEFEAT!"
      end
      restart_request
    elsif (@board.none?{|box| available?(box)} && !victory?)      
      puts "Messieurs, mesdames - you have come to a draw."
      restart_request
    else
      if @computer.nil?
        player == @player_1 ? @turn = @player_2 : @turn = @player_1
        relay_player_turns
      else
        player == @computer ? @turn = @human : @turn = @computer
        relay_computer_human_turns
      end
    end
  end

  def victory?
    sliced_board = @board.map{ |box| box.strip }.each_slice(@dimension).to_a
    reversed_sliced_board = sliced_board.map{ |a| a.reverse }

    sliced_board.any?{ |row| row.uniq.size == 1 } ||
    sliced_board.transpose.any?{ |row| row.uniq.size == 1 } ||
    (@dimension == 3 && (0..2).map{ |i| sliced_board[i][i] }.uniq.size == 1) ||
    (@dimension == 3 && (0..2).map{ |i| reversed_sliced_board[i][i] }.uniq.size == 1) ||
    (@dimension == 4 && (0..3).map{ |i| sliced_board[i][i] }.uniq.size == 1) ||
    (@dimension == 4 && (0..3).map{ |i| reversed_sliced_board[i][i] }.uniq.size == 1)  
  end

  def restart_request
    print "Would you like to play again? (Y/N) "
    if ["N","n"].include?(gets.chomp)
      exit(0)
    end
  end
end

if __FILE__ == $0
  loop do
    TTT.new.display_menu
  end
end