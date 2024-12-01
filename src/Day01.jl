using AdventOfCode2024

function  parse(data::String)::Tuple{Array{Int}, Array{Int}}
  mat = reduce(hcat, (pair->Base.parse.(Int, pair)).(split.(split(strip(data), "\n"))))
  mat[1,:], mat[2,:]
end


function part_one(list1::Array{Int}, list2::Array{Int})
  sort!(list1)
  sort!(list2)
  sum((((a, b),) -> abs(a-b)).(zip(list1, list2)))
end

"""
Assumes list1 and list2 are already sorted from the first part.
(Unnecessarily optimized...)
"""
function part_two(list1::Array{Int}, list2::Array{Int})
  sum = 0
  pos = 1
  len2 = length(list2)

  for a in list1
    # find pos of a in list2 ( or not existent)
    while list2[pos] < a
      pos += 1
      if pos > len2
        return sum
      end
    end

    # count a in list2
    fac = 0
    pos_count = pos
    while list2[pos_count] == a
      fac += 1
      pos_count += 1
      if pos_count > len2
        break
      end
    end
    sum += fac*a
  end
  sum
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(1, 1)
  list1, list2 = parse(input)

  println("Solution Part One: ", @time part_one(list1, list2))
  println("Solution Part Two: ", @time part_two(list1, list2))
end
