using AdventOfCode2024
using Debugger

function parse(data::String)::Vector{Tuple{Int, Int}}
  re = r"mul\((\d{1,3}),(\d{1,3})\)"
  Vector([(Base.parse(Int, m.captures[1]), Base.parse(Int, m.captures[2])) for m in eachmatch(re, data)])
end

function part_one(parsed)::Int
  sum(prod.(parsed))
end

function part_two(data::String)::Int
  re = r"(?:mul\((\d{1,3}),(\d{1,3})\)|don't\(\)|do\(\))"
  enabled = true
  sum = 0
  for m in eachmatch(re, data)
    if m.match == "don't()"
      enabled = false
    elseif m.match == "do()"
      enabled = true
    else
      if enabled
        parsed = Base.parse.(Int, m.captures)
        sum += parsed[1]*parsed[2]
      end
    end

  end
  sum
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(3)
  data = parse(input)

  println("Solution Part One: ", @time part_one(data))
  println("Solution Part Two: ", @time part_two(input))
end
