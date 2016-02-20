# challenge #228
# https://www.reddit.com/r/dailyprogrammer/comments/3h9pde/20150817_challenge_228_easy_letters_in/

# write a program that can determine if the letters in a word are in alphabetical order.
# bonus: see if you can check words spelled in reverse alphabetical order.

strings = string.split("\n")

strings.map(&:chars).map{|word|
  if word == word.sort
    word.join + " IN ORDER"
  elsif word == word.sort.reverse
    word.join + " REVERSE ORDER"
  else
    word.join + " NOT IN ORDER"
  end
}.join("\n")