# challenge #228
# https://www.reddit.com/r/dailyprogrammer/comments/3h9pde/20150817_challenge_228_easy_letters_in/

# write a program that determines if the letters in a word are in alphabetical order.
# bonus: see if you can check words spelled in reverse alphabetical order.

# `list`, a single string, is a list of words, each separated by newlines
def check_alphabetization(list)
  strings = list.split("\n")

  strings.map(&:chars).map{|word|
    if word == word.sort
      word.join + " IN ORDER"
    elsif word == word.sort.reverse
      word.join + " REVERSE ORDER"
    else
      word.join + " NOT IN ORDER"
    end
  }.join("\n")
end


# challenge #205
# https://www.reddit.com/r/dailyprogrammer/comments/2ygsxs/20150309_challenge_205_easy_friendly_date_ranges/

# implement a way of converting two dates into a more readable date range.
# do not show any redundant information in the date range.
# (i.e., if the year and month are the same in both dates,
# then only the day range should be displayed.)
# also, if the starting year is the current year
# and the ending year can be inferred by the reader,
# then the year should also be omitted.  

def output_readable_date_range(pair)
# `pair` is a single string comprising a pair of dates
# given in the yyyy-mm-dd format, separated by a single space

  require 'date'

  months = %w{January February March April May June 
              July August September October November December}

  ordinal_suffixes = %w{st nd rd th}

  this_year = Date.today.strftime("%Y").to_i

  # parse the dates, create a hash for each one, and add :yday key-value pairs to the hashes
  first_date = Date._parse(pair.split.first)
  first_date[:yday] = Date.new(first_date[:year], first_date[:mon], first_date[:mday]).yday

  second_date = Date._parse(pair.split.last)
  second_date[:yday] = Date.new(second_date[:year], second_date[:mon], second_date[:mday]).yday

  replace_month_and_day = lambda do |date|
    if date[:mday] % 10 == 0 || date[:mday] % 10 > 3 || (date[:mday] > 10 && date[:mday] < 20)
      date[:mday] = "#{date[:mday]}" + ordinal_suffixes.last
    else
      date[:mday] = "#{date[:mday]}" + ordinal_suffixes[date[:mday] % 10 - 1]
    end

    date[:mon] = months[date[:mon] - 1]
    date
  end

  first_date = replace_month_and_day.call(first_date)
  second_date = replace_month_and_day.call(second_date)

  if first_date == second_date
    # omit the extra date if both dates are the same
    first_date[:mon] + " #{first_date[:mday]}, " + "#{first_date[:year]}"
  elsif [first_date[:mon], first_date[:year]] == [second_date[:mon], second_date[:year]]
    # omit the extra month & year if both dates are in the same month & year
    first_date[:mon] + " #{first_date[:mday]} " + "- #{second_date[:mday]}, " + "#{second_date[:year]}" 
  elsif first_date[:year] == second_date[:year] ||
    [first_date[:mon], first_date[:mday]] == [second_date[:mon], second_date[:mday]]
    # omit the year from the 1st date if both dates are in the same year
    # || the month and day are the same in both dates
    # (to account for leap years, which might throw a wrench in the :yday comparison below)
    first_date[:mon] + " #{first_date[:mday]} " + "- #{second_date[:mon]} " + "#{second_date[:mday]}, " +
    "#{second_date[:year]}"
  elsif first_date[:year] == this_year &&
    second_date[:year] == this_year + 1 &&
    second_date[:yday] < first_date[:yday]
    # omit the year from both dates if the 1st date is this year
    # && the 2nd date is less than a year away (in the following year)
    first_date[:mon] + " #{first_date[:mday]} " + "- #{second_date[:mon]} " + "#{second_date[:mday]}"
  else
    first_date[:mon] + " #{first_date[:mday]}, " + "#{first_date[:year]}" + " - #{second_date[:mon]} " +
    "#{second_date[:mday]}, " + "#{second_date[:year]}"
  end
end