using AdventOfCode2024

function  parse(data::String)::Vector{Tuple{Int, Int}}
  re = r"mul\((\d{1,3}),(\d{1,3})\)"
  Vector([(parse(Int, m.captures[1]), parse(Int, m.captures[2])) for m in eachmatch(re, data)])
end

function part_one(data)::Int
  save = 0

  for (idx, row) in enumerate(data)
    if is_save(row) == -1
      save += 1
    end
  end

  save
end


if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(3)
  data = parse(input)

  println("Solution Part One: ", @time part_one(data))
  # println("Solution Part Two: ", @time part_two(data))
end
