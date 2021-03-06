

# project euler #49: prime permutation
# https://projecteuler.net/problem=49
# the arithmetic sequence, 1487, 4817, 8147, in which each of the
# terms increases by 3330, is unusual in two ways: (i) each of the
# three terms are prime, and, (ii) each of the 4-digit numbers are
# permutations of one another.
# there are no arithmetic sequences made up of three 1-, 2-, or
# 3-digit primes, exhibiting this property, but there is one other
# 4-digit increasing sequence.
# what 12-digit number do you form by concatenating the three terms in this sequence?

require 'prime'

# this range represents the upper & lower bounds of 4-digit primes
array = (1009..9973).to_a.select do |p|
  p.prime? && (p+3330).prime? && (p+6660).prime? &&
  p.to_s.chars.permutation.to_a.sort ==
  (p+3330).to_s.chars.permutation.to_a.sort &&
  p.to_s.chars.permutation.to_a.sort ==
  (p+6660).to_s.chars.permutation.to_a.sort
end

array.last.to_s + (array.last + 3330).to_s + (array.last + 6660).to_s 


# project euler #48: self powers
# https://projecteuler.net/problem=48
# the series 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.
# find the last 10 digits of the series 1**1 + 2**2 + 3**3 + ... + 1000**1000.

(1..1000).to_a.map{|n| n**n}.reduce(&:+).to_s[-10..-1].to_i


# project euler #47: distinct primes factors
# https://projecteuler.net/problem=47
# the first two consecutive numbers to have two distinct
# prime factors are: 
# 14 = 2 × 7 and 15 = 3 × 5
# the first three consecutive numbers to have three distinct
# prime factors are: 
# 644 = 2**2 × 7 × 23, 645 = 3 × 5 × 43, 646 = 2 × 17 × 19
# find the first four consecutive integers to have four distinct
# prime factors. What is the first of these numbers?

require 'prime'

(100000..999999).select{ |n| n.prime_division.count == 4 &&
  n.succ.prime_division.count == 4 && n.succ.succ.prime_division.count == 4 &&
  n.succ.succ.succ.prime_division.count == 4 }.first


# project euler #41: pandigital prime
# https://projecteuler.net/problem=41
# we shall say that an n-digit number is pandigital if it makes
# use of all the digits 1 to n exactly once.
# for example, 2143 is a 4-digit pandigital and is also prime.
# what is the largest n-digit pandigital prime that exists?

require 'prime'

pandigital_primes = (1..7).to_a.permutation.to_a.map(&:join).select do |p|
  p.to_i.prime?
end

pandigital_primes.last.to_i


# project euler #37: truncatable primes
# https://projecteuler.net/problem=37
# the number 3797 has an interesting property.
# being prime itself, it is possible to continuously remove digits from
# left to right, and remain prime at each stage: 3797, 797, 97, and 7.
# similarly we can work from right to left: 3797, 379, 37, and 3.

# find the sum of the only eleven primes that are both truncatable from
# left to right and right to left.
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

require 'prime'

truncatable_primes = []

Prime.each(1000000) do |p|
  string = p.to_s
  char_array = string.chars
  temp_array = [] << p

  string.each_char do |c|
    char_array.rotate!.pop
    temp_array << char_array.join.to_i
  end

  temp_array.pop
  char_array = string.chars

  string.each_char do |c|
    char_array.pop
    temp_array << char_array.join.to_i
  end

  temp_array.pop

  if temp_array.all?{|n| n.prime?} && string.length > 1
    truncatable_primes << p
  end

  truncatable_primes.uniq!
end

truncatable_primes.reduce(&:+)


# project euler #35: circular primes
# https://projecteuler.net/problem=35
# the number, 197, is called a circular prime because all rotations
# of the digits: 197, 971, and 719, are themselves prime.
# there are thirteen such primes below 100:
# 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
# how many circular primes are there below one million?

require 'prime'

circular_primes = []

Prime.each(1000000) do |num|
  temp_array = []
  char_array = num.to_s.chars

  char_array.each_index do |i|
    temp_array << char_array.rotate(i).join.to_i
  end

  if temp_array.all?{ |n| n.prime? }
    circular_primes << num
  end
end

circular_primes.count


# project euler #30: digit fifth powers
# https://projecteuler.net/problem=30
# surprisingly there are only three numbers that can be written as
# the sum of fourth powers of their digits:
# 1634 = 1**4 + 6**4 + 3**4 + 4**4
# 8208 = 8**4 + 2**4 + 0**4 + 8**4
# 9474 = 9**4 + 4**4 + 7**4 + 4**4
# the sum of these numbers is 1634 + 8208 + 9474 = 19316.
# find the sum of all the numbers that can be written as the sum of
# fifth powers of their digits.

(4150..1000000).to_a.select{|n| n == n.to_s.chars.map(&:to_i).map{|n|n**5}.reduce(&:+)}.reduce(&:+)


# project euler #29: distinct powers
# https://projecteuler.net/problem=29
# consider all integer combinations of a**b for 2 ≤ a ≤ 5 and 2 ≤ b ≤ 5:
# 2**2=4, 2**3=8, 2**4=16, 2**5=32
# 3**2=9, 3**3=27, 3**4=81, 3**5=243
# 4**2=16, 4**3=64, 4**4=256, 4**5=1024
# 5**2=25, 5**3=125, 5**4=625, 5**5=3125
# if they are then placed in numerical order, with any repeats removed,
# we get the following sequence of 15 distinct terms:
# 4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125
# how many distinct terms are in the sequence generated by a**b for 2 ≤ a ≤ 100 and 2 ≤ b ≤ 100?

(2..100).to_a.flat_map{|exp|
  (2..100).to_a.map{|num| num**exp}}.uniq.count


# project euler #25: 1000-digit fibonacci number
# https://projecteuler.net/problem=25
# what is the index of the first term in
# the Fibonacci sequence to contain 1000 digits?

def fibonacci(n)
  return [0] if n==1
  return [0,1] if n==2
  
  previous = fibonacci(n-1)
  previous << previous[-2] + previous.last
  previous
end

first_term = fibonacci(4800).select{|n| n.to_s.length==1000}.first

fibonacci(4800).index(first_term)


# project euler #24: lexicographic permutations
# https://projecteuler.net/problem=24
# a permutation is an ordered arrangement of objects;
# if all of the permutations are listed numerically or alphabetically,
# we call it lexicographic order.
# the lexicographic permutations of 0, 1 and 2 are:
# 012   021   102   120   201   210
# what is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

(0..9).to_a.map(&:to_s).permutation.to_a[999999].join.to_i


# project euler #20: factorial digit sum
# https://projecteuler.net/problem=20
# n! means n × (n − 1) × ... × 3 × 2 × 1
# find the sum of the digits in the number 100!

(1..100).to_a.reduce(&:*).to_s.chars.map(&:to_i).reduce(&:+)


# project euler #19: counting sundays
# https://projecteuler.net/problem=19
# how many Sundays fell on the first of the month during
# the twentieth century (1 Jan 1901 to 31 Dec 2000)?

Date.new(1901,1,1).step(Date.new(2000,12,31)).select{|date| date.sunday? &&
  date.strftime("%d") == "01"}.size


# project euler #13: large sum
# # https://projecteuler.net/problem=13
# find the first 10 digits of the sum of the given one-hundred 50-digit numbers.

string.lines.map(&:chomp).map(&:to_i).reduce(&:+).to_s[0..9].to_i


# project euler #10: summation of primes
# https://projecteuler.net/problem=10
# the sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# find the sum of all the primes below two million.

require 'prime'
primes = []
Prime.each(2000000){ |n| primes << n }
primes.reduce(&:+)


# project euler #8: largest product in a series
# # https://projecteuler.net/problem=8
# the four adjacent digits in the 1000-digit number that have the
# greatest product are 9 × 9 × 8 × 9 = 5832.
# find the thirteen adjacent digits in the 1000-digit number that
# have the greatest product. What is the value of this product?

string = "73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450"

strings = string.split('0').map{|s| s.chars.select{|c| c.to_i > 0}}.select{|s| s.length > 12}
products = strings.flat_map{|s| s.each_cons(13).to_a}.map{|s| s.map(&:to_i)}.map{|a| a.reduce(&:*)}
products.max


# project euler #7: 1001st prime
# https://projecteuler.net/problem=7
# by listing the first six prime numbers (2, 3, 5, 7, 11, 13)
# we can see that the 6th prime is 13.
# find the 10,001st prime number.

require 'prime'
Prime.first(10001).last


# project euler #6: sum square difference
# https://projecteuler.net/problem=6
# the sum of the squares of the first ten natural numbers is:
# 1**2 + 2**2 + ... + 10**2 = 385
# the square of the sum of the first ten natural numbers is:
# (1 + 2 + ... + 10)**2 = 552 = 3025
# hence, the difference between the sum of the squares of
# the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
# find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.

(1..100).reduce(&:+)**2 - (1..100).map{ |n| n**2 }.reduce(&:+)


# project euler #5: smallest multiple
# https://projecteuler.net/problem=5
# 2520 is the smallest number that can be divided by
# each of the numbers from 1 to 10 without any remainder.
# find the smallest positive number that is evenly divisible
# by all of the numbers from 1 to 20.
array = Array.new

(813960..465585120).each do |num|
  if (11..20).all?{ |n| num % n == 0 }
    array << num
  end
end

array.first


# project euler #4: largest palindrome product
# https://projecteuler.net/problem=4
# a palindromic number reads the same both ways.
# the largest palindrome made from the product of two 2-digit numbers is 9009 = 99. * 91
# find the largest palindrome made from the product of two 3-digit numbers.

# see http://stackoverflow.com/questions/3398159/all-factors-of-a-given-number
factors = lambda do |num|
  (1..num).map{ |n| [n, num/n] if ((num/n) * n == num) }.compact
end

def palindrome_products
  (10001..1000001).select{ |num| num == num.to_s.reverse.to_i &&
    factors.call(num).any?{
      |array| array.all?{
        |i| i.to_s.length == 3}
      }
    }.last
end


# project euler #3: largest prime factor
# https://projecteuler.net/problem=3
# the prime factors of 13195 are 5, 7, 13 and 29.
# what is the largest prime factor of the number 600851475143?
# also see https://stackoverflow.com/questions/3398159/all-factors-of-a-given-number/3398195#3398195

require 'prime'

600851475143.prime_division.last.first

# def max_prime_factor(num)
# # returns the largest prime factor of num
# # does not work for Bignums..... ;_;
#   (2..num).select{ |n| (num % n == 0) && (2...n).none?{ |i| n % i == 0} }.max
# end


# project euler #2: even fibonacci numbers
# https://projecteuler.net/problem=2
# each new term in the fibonacci sequence is the sum of the previous two terms:
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584
# find the sum of the even-valued terms whose values are < or == 4,000,000.

def fib_sequence(n)
# creates array of terms that are less than or equal to n
  array = [0,1]

  # add terms to array until term exceeds n
  i = 2
  while array.last < n
    array << (array[i-2] + array[i-1])
    i += 1  
  end
  array.select!{ |x| x < n || x == n }
end

# def fib_sequence(n)
# # creates array for the first n terms
#   array = [0,1]
#   (2..(n+1)).map do |i|
#     array[i] = array[i-2] + array[i-1]
#   end
# end 

def even_fib_sum(array)
# finds sum of array's even-valued terms
  array.select{ |i| i.even? }.reduce(&:+)
end

def solution(n)
  even_fib_sum(fib_sequence(n))
end

# project euler #1: multiples of 3 and 5
# sum all multiples of 3 or 5 below 1000
# https://projecteuler.net/problem=1
def fizzbuzzsum(n)
 (3...n).select{ |i| i % 3 == 0 || i % 5 == 0 }.reduce(&:+)
end