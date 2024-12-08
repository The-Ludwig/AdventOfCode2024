using AdventOfCode2024

function parse(s::String)::Vector{Tuple{Int,Vector{Int}}}
  function parse_row(row)
    sum, nums = split(row, ":")
    sum = Base.parse(Int, strip(sum))
    nums = Base.parse.(Int, split(nums))
    sum, nums
  end
  parse_row.(split(strip(s), '\n'))
end


function part_one(tests)
  answer = 0
  for (checksum, nums) in tests
    # store all possible current paths
    # Kind of the leaves of the current computation tree
    leaves::Vector{Int} = [nums[1]]

    for num in nums[2:end]
      new_leaves = []
      for leave in leaves
        if (mult = leave * num) <= checksum
          push!(new_leaves, mult)
        end
        if (sum = leave + num) <= checksum
          push!(new_leaves, sum)
        end
      end
      leaves = new_leaves
    end

    if checksum in leaves
      answer += checksum
    end
  end

  answer
end

function int_log(num, base=10)
  cur = num
  pow = 0
  while (cur = div(cur, base)) > 0
    pow += 1
  end
  pow
end

function part_two(tests)
  answer = 0
  for (checksum, nums) in tests
    # store all possible current paths
    # Kind of the leaves of the current computation tree
    leaves::Vector{Int} = [nums[1]]

    for num in nums[2:end]
      new_leaves = []
      for leave in leaves
        if (mult = leave * num) <= checksum
          push!(new_leaves, mult)
        end

        if (sum = leave + num) <= checksum
          push!(new_leaves, sum)
        end

        if (concat = (leave * (10^(int_log(num) + 1)) + num)) <= checksum
          @debug "$leave || $num = $concat"
          push!(new_leaves, concat)
        end
      end
      leaves = new_leaves
    end

    if checksum in leaves
      answer += checksum
      @debug "$checksum doable"
    end

  end

  answer
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(7)
  parsed = parse(input)

  println("Solution Part One: ", @time part_one(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
end
