

# project euler #3:
# the prime factors of 13195 are 5, 7, 13 and 29.
# what is the largest prime factor of the number 600851475143?

def max_prime_factor(num)
# returns the largest prime factor of num
  (2..num).select{|n| (num%n==0) && (2...n).none?{|i| n%i==0}}.max
end

# codewars kata: is a number prime?
# http://www.codewars.com/kata/is-a-number-prime
def isPrime(num)
# returns whether num is a prime number
  num > 1 && (2...num).none?{|n| num % n == 0}
end


# project euler #2: even fibonacci numbers
# https://projecteuler.net/problem=2
# each new term in the fibonacci sequence is the sum of the previous two terms:
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584
# find the sum of the even-valued terms whose values are < or = 4,000,000.

def fib_sequence(n)
# creates array of terms that are less than or equal to n
  array = [0,1]

  # add terms to array until term exceeds n
  i = 2
  while array.last < n
    array << (array[i-2] + array[i-1])
    i += 1  
  end
  array.select!{|x| x<n || x==n }
end

def even_fib_sum(array)
# finds sum of array's even-valued terms
  array.select{ |i| i.even? }.reduce(&:+)
end

def fib_sequence(n)
# creates array for the first n terms
  array = [0,1]
  (2..(n+1)).map do |i|
    array[i] = array[i-2] + array[i-1]
  end
end 


# project euler #1: sum all multiples of 3 or 5 below 1000
# https://projecteuler.net/problem=1
def fizzbuzzsum(n)
 (3...n).select { |i| i%3 == 0 || i%5 == 0 }.reduce(&:+)
end


# codewars kata: vasya and stairs
# http://www.codewars.com/kata/vasya-and-stairs/train/ruby
def numberOfSteps(steps, m)
  result = ((steps/2 + steps%2)..steps).select{ |n| n%m==0 }.first 
  if result ? result : -1
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