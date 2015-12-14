# codewars kata: sudoku solution validator
# http://www.codewars.com/kata/sudoku-solution-validator/train/ruby
def validSolution(board)

  array_of_boxes = Array.new
  box = Array.new
  i = 0

  # add arrays for 1st column of boxes
  3.times do
    3.times do
      row = board[i]
      box.push(row[0]).push(row[1]).push(row[2])
      i += 1
    end

    array_of_boxes << box
    box = Array.new
  end

  # reset index & rotate each row
  i = 0
  board.each{ |row| row.rotate!(3) }

  # add arrays for 2nd column of boxes
  3.times do
    3.times do
      row = board[i]
      box.push(row[0]).push(row[1]).push(row[2])
      i += 1
    end

    array_of_boxes << box
    box = Array.new
  end

  # reset index & rotate each row
  i = 0
  board.each{ |row| row.rotate!(3) }

  # add arrays for 3rd column of boxes
  3.times do
    3.times do
      row = board[i]
      box.push(row[0]).push(row[1]).push(row[2])
      i += 1
    end

    array_of_boxes << box
    box = Array.new
  end

  all_possible_arrays = (1..9).to_a.permutation.to_a

  # each row & each column is a unique permutation of base_array
  board.all?{ |row| all_possible_arrays.include?(row) } &&
  board.uniq.size == 9 &&
  board.transpose.all?{ |column| all_possible_arrays.include?(column) } &&
  board.transpose.uniq.size == 9 &&
  array_of_boxes.all? { |box| all_possible_arrays.include?(box) }
end

  # try these methods: rotate, shift, assoc, rassoc, combination, send, slice
  # check each array for uniqueness?
  # stop if any array has non-unique items?
  
true_example =
[[5, 3, 4, 6, 7, 8, 9, 1, 2], 
 [6, 7, 2, 1, 9, 5, 3, 4, 8],
 [1, 9, 8, 3, 4, 2, 5, 6, 7],
 [8, 5, 9, 7, 6, 1, 4, 2, 3],
 [4, 2, 6, 8, 5, 3, 7, 9, 1],
 [7, 1, 3, 9, 2, 4, 8, 5, 6],
 [9, 6, 1, 5, 3, 7, 2, 8, 4],
 [2, 8, 7, 4, 1, 9, 6, 3, 5],
 [3, 4, 5, 2, 8, 6, 1, 7, 9]]

 # these indices represent the start of each box... [0,3,6]
board[0][0],board[0][1],board[0][2]
board[1][0],board[1][1],board[1][2]
board[2][0],board[2][1],board[2][2]

board[3][0],board[3][1],board[3][2]
board[4][0],board[4][1],board[4][2]
board[5][0],board[5][1],board[5][2]

board[6][0],board[6][1],board[6][2]
board[7][0],board[7][1],board[7][2]
board[8][0],board[8][1],board[8][2]

# divide rows into thirds?

box_1 =
board[0][0],board[0][1],board[0][2]
board[1][0],board[1][1],board[1][2]
board[2][0],board[2][1],board[2][2]

# codewars kata: josephus permutation
# http://www.codewars.com/kata/5550d638a99ddb113e0000a2/train/ruby
# for best solutions, see http://www.codewars.com/kata/5550d638a99ddb113e0000a2/solutions/ruby
def josephus(items,k)
  new_array = []
  while items.size > (k-1)
    new_array << items.delete_at(k-1)
    items.rotate!(k-1) 
  end
  while items.size > 0
    items.rotate!(k-1) 
    new_array << items.delete_at(0)
  end
  new_array
end


# codewars kata: word a9n (abbreviation)
# http://www.codewars.com/kata/word-a9n-abbreviation/train/ruby
class Abbreviator
  def self.abbreviate(string)
    string.split(%r{\b}).map{ |item|
     if %r([a-zA-Z]{4,}).match(item)
       item.replace("#{item[0]}#{item.size-2}#{item[-1]}")
     else
       item
     end
     }.join
  end
end


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
  return array.join(" & ") if array.size < 2
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