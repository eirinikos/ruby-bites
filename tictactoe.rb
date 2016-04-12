class Player
  attr_accessor :type, :token, :turn
  # a player's type, token, and turn are publicly accessible outside of this class

  def initialize(type, token)
    @type = type # human, computer, human_1, or human_2
    @token = token
    @turn = false
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
  attr_accessor :ascii_representation, :dimension
  # a board's ascii_representation & dimension are publicly accessible

  def initialize(dimension)
    @ascii_representation = asciify(dimension)
  end

  def display(ascii_representation)
  end

  AsciiBoard = Struct.new(:array)

  def asciify(dimension)
    AsciiBoard.new((1..dimension**2).to_a.map(&:to_s))
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