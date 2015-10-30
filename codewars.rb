# codewars kata: enigma machine (plugboard)
# http://www.codewars.com/kata/5523b97ac8f5025c45000900/train/ruby

class Plugboard
  def initialize(wires)
    if wires.size.even? && (wires.size/2) < 11 && wires.split(%r{\s*})==wires.split(%r{\s*}).uniq
      # what about a string of odd-numbered size that includes a valid number of A-Z pairs, plus some non-A-Z characters?
      @wires = wires
    else
      "Invalid input!"
    end
  end
  def process(wire)
    # find wire in @wires
    # if wire is not within @wires, return wire unchanged
    # if wire is not within A-Z, return wire unchanged
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