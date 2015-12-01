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
    case @place
    when 1, 2, 3
      if @row_1[place - 1].class == Fixnum
        @row_1[place - 1] = player
      else
        occupied_box_prompt(player)
      end
    when 4, 5, 6
      if @row_2[place - 4].class == Fixnum
        @row_2[place - 4] = player
      else
        occupied_box_prompt(player)
      end
    else
      if @row_3[place - 7].class == Fixnum
        @row_3[place - 7] = player
      else
        occupied_box_prompt(player)
      end
    end
    
    if victory?
      print_board
      puts "\nCONGRATULATIONS! You have vanquished your foe!\n\n(╯°□°)╯︵ ┻━┻\n\n"
      restart?
    elsif (@board.all? {|row| row.all? {|i| i.class == String} } && !victory?)
      puts "Messieurs, mesdames - you have come to a draw."
      restart?
    else
      player == @p1 ? @turn = @p2 : @turn = @p1
      turns
    end
  end

  def turns
    print_board
    if @p1.nil?  
      print "\nPlayer 1, make your move!\nDo you want to play an X or an O? "
      @p1 = gets.chomp
      x_or_o_chosen?
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

  def x_or_o_chosen?
    if ["X","O","x","o"].include?(@p1)
      @p1.upcase!
      print "Excellent choice. In which box would you like to place your #{@p1}? "
      player_move(@p1)
    else
      print "Sir / Madam, please choose X or O: "
      @p1 = gets.chomp
      x_or_o_chosen?
    end
  end

  def player_move(player) 
    @place = gets.chomp.to_i
    if (1..9).include?(@place)
      update_board(player, @place)
    else
      print "Sir / Madam, please choose a valid number: "
      player_move(player)
    end
  end

  def occupied_box_prompt(player)
    print_board
    print "\nSTOP in the name of the law! That box is occupied - please choose another one. "
    player_move(player)
  end

  def victory?
    reverse_board = @board.map{ |a| a.reverse }
    @board.map{ |row| row.uniq.size == 1 }.any? ||
    @board.transpose.map{ |row| row.uniq.size == 1 }.any? ||
    (0..2).map{ |i| @board[i][i] }.uniq.size == 1 ||
    (0..2).map{ |i| reverse_board[i][i] }.uniq.size == 1
  end

  def restart?
    print "Would you like to play again? (Y/N) "
    if ["Y","y"].include?(gets.chomp)
      @p1 = nil
      initialize
      turns
    end
  end
end

b = TTT.new
b.turns