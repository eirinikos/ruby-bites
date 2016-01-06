def fibonacci n
  return [0] if n==1
  return [0,1] if n==2
  
  # uncommenting line 8 & commenting-out lines 2-3
  # prints a '.' for each stack level

  # print '.'

  previous = fibonacci(n-1)
  previous << previous[-2] + previous.last
  previous
end