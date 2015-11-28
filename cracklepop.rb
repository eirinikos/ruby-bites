# Write a program that prints out the numbers 1 to 100 (inclusive).
# If the number is divisible by 3, print Crackle instead of the number.
# If it's divisible by 5, print Pop.
# If it's divisible by both 3 and 5, print CracklePop.

def cracklepop
  (1..100).to_a.map { |n|
    if n % 15 == 0
      "CracklePop"
    elsif n % 3 == 0
      "Crackle"
    elsif n % 5 == 0
      "Pop"
    else
      n
    end
  }.join(", ")
end