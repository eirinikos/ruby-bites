# challenge #228
# https://www.reddit.com/r/dailyprogrammer/comments/3h9pde/20150817_challenge_228_easy_letters_in/

# write a program that can determine if the letters in a word are in alphabetical order.
# bonus: see if you can check words spelled in reverse alphabetical order.

strings = string.split("\n")

ascii_values = strings.map(&:chars).map{|chars| chars.map(&:ord)}

ascii_values.map{|ascii_set|
  if ascii_set == ascii_set.sort
    ascii_set.map(&:chr).join + " IN ORDER"
  elsif ascii_set == ascii_set.sort.reverse
    ascii_set.map(&:chr).join + " REVERSE ORDER"
  else
    ascii_set.map(&:chr).join + " NOT IN ORDER"
  end
}.join("\n")