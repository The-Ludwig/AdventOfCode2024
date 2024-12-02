using AdventOfCode2024
using DelimitedFiles

function  parse(data::String)::Vector{Vector{Int}}
  (row->Base.parse.(Int, split(row))).(split(strip(data), "\n"))
end

function is_save(level)::Int
  # increasing or decreasing?
  sign = (level[2]-level[1]) > 0
  last = level[1]

  # check condition for every difference
  for (idx, i) in enumerate(level[2:end])
    dif = i-last
    
    if ((dif > 0) != sign) || (abs(dif) == 0) || (abs(dif) > 3)
      return idx+1
    end

    last = i
  end

  -1
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

function remove_at(a, i)
  vcat(a[1:i-1], a[i+1:end])
end

function part_two(data)::Int
  save = 0

  for (idx, row) in enumerate(data)
    res = is_save(row)
    if res == -1
      save += 1
    else
      if is_save(remove_at(row, res)) == -1
        save += 1
      elseif is_save(remove_at(row, res-1)) == -1
        save += 1
      end
    end
  end

  save
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(2)
  data = parse(input)

  println("Solution Part One: ", @time part_one(data))
  println("Solution Part Two: ", @time part_two(data))
end
