using AdventOfCode2024
using Debugger
using Printf

function parse(input::String)
  Base.parse.(Int, split(input))
end

function digits(num::Int)
  digs = 0
  num = copy(num)
  while num > 0
    digs += 1
    num = div(num, 10)
  end

  digs
end

function replace(num::Int)::Vector{Int}
  if num == 0
    return [1]
  elseif (digs = digits(num)) % 2 == 0
    return [div(num, 10^(digs/2)), num % (10^(digs/2))]
  else
    return [num*2024]
  end
end


function get_multiplication!(num, len, cache)
  if len == 0
    return 1
  end

  haskey(cache, (num, len)) && return cache[(num, len)]

  sum = 0
  for nn in replace(num)
    sum += get_multiplication!(nn, len-1, cache)
  end

  cache[(num, len)] = sum
  sum
end

function part_one(nums)
  cache = Dict()
  sum = 0
  for num in nums
    sum += get_multiplication!(num, 25, cache)
  end

  sum
end

function part_two(nums)
  cache = Dict()
  sum = 0
  for num in nums
    sum += get_multiplication!(num, 75, cache)
  end

  sum
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(11)
  parsed = parse(input)

  @printf("%d\n", part_one(parsed))
  println("Solution Part One: ", @time part_one(parsed))
  @printf("%d\n", part_two(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
end
