# project euler #7:
# https://projecteuler.net/problem=7
# by listing the first six prime numbers (2, 3, 5, 7, 11, 13)
# we can see that the 6th prime is 13.
# find the 10,001st prime number.

require 'prime'
Prime.first(10001).last

# project euler #6:
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


# project euler #5:
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


# project euler #4:
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


# project euler #3:
# https://projecteuler.net/problem=3
# the prime factors of 13195 are 5, 7, 13 and 29.
# what is the largest prime factor of the number 600851475143?

def max_prime_factor(num)
# returns the largest prime factor of num
# does not work for Bignums..... ;_;
  (2..num).select{ |n| (num % n == 0) && (2...n).none?{ |i| n % i == 0} }.max
end


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

# project euler #1: sum all multiples of 3 or 5 below 1000
# https://projecteuler.net/problem=1
def fizzbuzzsum(n)
 (3...n).select{ |i| i % 3 == 0 || i % 5 == 0 }.reduce(&:+)
end