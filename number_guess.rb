# determine a random number from 1-100 & let the user guess the number
# report back whether their guess is correct, too high, or too low

# if the user guesses a number they've already guessed,
# tell them they have previously guessed this number

# once they've guessed the correct number, congratulate them &
# tell them how many guesses they took to solve the problem (minus any duplicate guesses)

class Game
  def initialize
    @random_num = (1..100).to_a.sample
    @all_guesses = Array.new
  end

  def initial_prompt
    print "\nGuess the number I have chosen (it's between 1 and 100): "
    receive_guess
  end

  def receive_guess
    @guess = gets.chomp.to_i
    check_guess(@guess)
  end

  def check_guess(guess)
    if (1..100).include?(@guess.to_i)
      if @all_guesses.include?(@guess)
        print "\nHEY! You've already guessed that! Guess again: "
        receive_guess
      else
        @all_guesses << @guess 
      end
      
      if @guess == @random_num
        print "\nCONGRATULATIONS! It only took you #{@all_guesses.count} unique guesses to guess correctly!"
        print "\nBye now!\n\n"
        exit(0) 
      elsif @guess < @random_num
        print "\nYour guess is too low. Try again: "
        receive_guess
      else
        print "\nYour guess is too high. Try again: "
        receive_guess
      end
    else
      print "\nThat's not a valid choice."
      initial_prompt
    end
  end
end

Game.new.initial_prompt