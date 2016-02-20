# challenge #228
# https://www.reddit.com/r/dailyprogrammer/comments/3h9pde/20150817_challenge_228_easy_letters_in/

# write a program that can determine if the letters in a word are in alphabetical order.
# bonus: see if you can check words spelled in reverse alphabetical order.

final_output = []

strings = string.split("\n")

ascii_values = strings.map{|word| word.chars}.map{|chars| chars.map{|char| char.ord}}

ascii_values.each_with_index do |ascii, index|
  if ascii == ascii.sort
    final_output << (strings[index] + " IN ORDER")
  elsif ascii == ascii.sort.reverse
    final_output << (strings[index] + " REVERSE ORDER")
  else
    final_output << (strings[index] + " NOT IN ORDER")
  end
end

final_output