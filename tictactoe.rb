class Player
  attr_accessor :type, :token, :turn
  # a player's type, token, and turn are publicly accessible outside of this class

  def initialize(type, token, turn=false)
    @type = type # human, computer, human_1, or human_2
    @token = token
    @turn = turn
  end

  def says_yes?
    ["Y","y"].include?(gets.chomp)
  end

  def plays_first?
  end

  def has_turn?
  end

  def has_valid_token?
  end

  def think()
  end

  def makes_valid_move?
  end

  def move()
  end
end

class Board
  attr_accessor :dimension
  # a board's dimension attribute is publicly accessible

  def initialize(dimension)
    @dimension = dimension
  end

  def display
    "\n"
    asciify.each do |row|
      puts "#{row}"
      if row != asciify.last
        puts "-" * (dimension**2 + (dimension-1))
      end
    end
  end

  def asciify
    arrayify.each_slice(dimension).to_a.flat_map do |slice|
      slice.map {|cell|
        cell != slice.last ? "#{cell}".center(dimension) + "|" : "#{cell}".center(dimension)}.join
    end
  end

  def arrayify
    (1..dimension**2).to_a.map(&:to_s)
  end
end

class Game
  def main_menu
  end

  def victory?
    # enforce single responsibility everywhere
    # separate iteration from the action that's being performed on each element
  end

  def game_over?
  end

  def restart?
    print "Would you like to play again? (Y/N) "
    Player.says_yes?
  end

  def restart
    if restart?
      main_menu
    end
  end

  def quit
    exit(0)
  end
end

### test for boards of various dimensions
(1..8).map{|i| Board.new(i).display}
