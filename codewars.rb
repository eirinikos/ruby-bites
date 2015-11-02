#codewars kata: word a9n (abbreviation)
# http://www.codewars.com/kata/word-a9n-abbreviation/train/ruby

class Abbreviator
  def self.abbreviate(string)
    # find sub-string within string that has at least 4 char
    # a non-alphabetic char splits letters into 2 words
  end
end

Abbreviator.abbreviate("banana") # => "b4a"
Abbreviator.abbreviate("double-barrel") #=>"d4e-b4l"
Abbreviator.abbreviate("You, and I, should speak.") #=>"You, and I, s4d s3k."


# codewars kata: format a string of names
# http://www.codewars.com/kata/format-a-string-of-names-like-bart-lisa-and-maggie/train/ruby

def list(names)
  array = names.map{|n| n.values}
  if array.size > 2
    array[0..-2].join(", ") + " & #{array[-1][0]}"
  else
    array.join(" & ")
  end
end

# refactored...
def list(names)
  array = names.map{|n| n.values}
  return array.join(" & ") if array.size < 2a
  array[0..-2].join(", ") + " & #{array[-1][0]}"
end

# codewars kata: enigma machine (plugboard)
# http://www.codewars.com/kata/5523b97ac8f5025c45000900/train/ruby
class Plugboard
  def initialize(wires="")
    array = wires.split(%r{\s*})
    if array.none?{|i| !("A".."Z").include?(i)} && array.size.even? && (array.size/2)<11 && array==array.uniq
      # if array includes only char within "A".."Z" range
      # && if array is even and has 10 or less pairs of A..Z characters, all unique
      @wires = array
    else
      raise
    end
  end
  def process(wire)
    # @wires pairs char in even-odd index pairs: @wires[0] & @wires[1], and so on..
    if wire.size > 1
      "Please enter a single character."
    elsif !@wires.include?(wire)
      wire
    elsif @wires.index(wire).even?
      @wires[@wires.index(wire) + 1]
    else @wires.index(wire).odd?
      @wires[@wires.index(wire) - 1]
    end
  end
end

#refactored...
class Plugboard
  def initialize(wires="")
    @wires = wires
    raise if @wires.size.odd? || (@wires.size/2)>10 || @wires != @wires.chars.uniq.join
  end
  def process(wire)
    i = @wires.chars.index(wire)
    if wire.size > 1
      "Please enter a single character."
    elsif i.nil?
      wire
    elsif i.even?
      @wires[i+1]
    else i.odd?
      @wires[i-1]
    end
  end
end


# codewars kata: pentabonacci
# http://www.codewars.com/kata/55c9172ee4bb15af9000005d/train/ruby
def count_odd_pentaFib(n)
  array = [0,1,1,2,4,8]
  (5..n).each do |i|
    array[i] = array[i-5] + array[i-4] + array[i-3] + array[i-2] + array[i-1]
  end
  array.select{|i| i.odd?}.uniq!.count
end


# codewars kata: counting in the amazon
# http://www.codewars.com/kata/55b95c76e08bd5eef100001e/train/ruby
def count_arara(n)
  arara_array = []
  (n/2).times{ |i| arara_array << "adak" }
  (n%2).times{ |i| arara_array << "anane" }
  arara_array.join(" ")
end

#refactored...
def count_arara(n)
  (["adak"] * (n/2) + ["anane"] * (n%2)).join(" ")
end

Test.assert_equals(count_arara(1),"anane");
Test.assert_equals(count_arara(2),"adak");
Test.assert_equals(count_arara(3),"adak anane");
Test.assert_equals(count_arara(9),"adak adak adak adak anane");


# codewars kata: is a number prime?
# http://www.codewars.com/kata/is-a-number-prime
def isPrime(num)
# returns whether num is a prime number
  num > 1 && (2...num).none?{|n| num % n == 0}
end


# codewars kata: vasya and stairs
# http://www.codewars.com/kata/vasya-and-stairs/train/ruby
def numberOfSteps(steps, m)
  ((steps/2 + steps%2)..steps).find{ |n| n%m==0 } || -1
end

  # steps = array.reduce(&:+)
      
  Test.assert_equals(numberOfSteps(7, 5), 5)
    # array_of_arrays = [[2,2,2,1], [2,2,1,1,1], [2,1,1,1,1,1], [1,1,1,1,1,1,1]]
    # array_of_array_lengths = [4, 5, 6, 7]

  Test.assert_equals(numberOfSteps(10, 2), 6)
    # array_of_arrays = [[2,2,2,2,2], [2,2,2,2,1,1],[2,2,2,1,1,1,1], [2,2,1,1,1,1,1,1], 
    # [2,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1]]
    # array_of_array_lengths = [5, 6, 7, 8, 9, 10]

  Test.assert_equals(numberOfSteps(12, 3), 6)
    # array_of_arrays = [[2,2,2,2,2,2], [2,2,2,2,2,1,1], [2,2,2,2,1,1,1,1],
    # [2,2,2,1,1,1,1,1,1], [2,2,1,1,1,1,1,1,1,1], [2,1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1,1,1]]
    # array_of_array_lengths = [6, 7, 8, 9, 10, 11, 12]


# codewars kata: sum of top-left to bottom-right diagonals
# http://www.codewars.com/kata/5497a3c181dd7291ce000700/train/ruby
def diagonalSum(matrix)
  (0...matrix.size).map { |i| matrix[i][i] }.reduce(&:+)
end


# codewars kata: musical pitch classes
# http://www.codewars.com/kata/musical-pitch-classes/solutions/ruby/me/best_practice
def pitch_class(note)
  array_with_sharps = [
  'B#', 'C#', 'D', 'D#', 'E', 'E#', 'F#', 'G', 'G#', 'A', 'A#', 'B']
  array_with_flats = [
  'C','Db', 'D', 'Eb', 'Fb', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'Cb']
  
    array_with_sharps.index(note) ||
    array_with_flats.index(note)
end