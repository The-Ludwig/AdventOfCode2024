using AdventOfCode2024
using Debugger
using Printf

function parse(input::String)::Vector{Int8}
  Base.parse.(Int8, collect(input))
end

function part_one(data::Vector{Int8})
  list = []
  pause = false
  data = copy(data)

  last_num = div(length(data), 2)

  i = 0
  while length(data) > 0
    num = popfirst!(data)

    if pause
      for j in 1:num
        push!(list, last_num)
        data[end] -= 1

        if data[end] == 0
          pop!(data)
          pop!(data)
          last_num -= 1
        end
      end
    else
      append!(list, i * ones(num))
      i += 1
    end

    pause = !pause
  end

  sum((0:length(list)-1) .* list)
end

function part_two(data::Vector{Int8})
  nums = Vector{Tuple{Int,Int}}()
  pauses = Vector{Int}()
  nums = map(t -> (div(t[1], 2), t[2]), Iterators.filter(t -> (t[1] % 2) == 1, enumerate(data)))
  pauses = map(t -> t[2], Iterators.filter(t -> t[1] % 2 == 0, enumerate(data)))
  push!(pauses, 0)


  new_nums = Dict{Int,Vector{Tuple{Int,Int}}}()
  removed_indices = []
  for (inum, (number, nnum)) in Iterators.reverse(enumerate(nums))
    for (ip, pause) in enumerate(pauses[1:inum-1])
      if pause >= nnum
        if !haskey(new_nums, ip)
          new_nums[ip] = Vector{Tuple{Int,Int}}()
        end
        push!(new_nums[ip], (number, nnum))
        pauses[ip] -= nnum
        push!(removed_indices, inum)
        pauses[inum-1] += nnum
        break
      end
    end
  end

  checksum = 0
  pos = 0

  for (inum, (number, nnum)) in enumerate(nums)
    if !(inum in removed_indices)
      # add to sum
      for i in pos:pos+nnum-1
        checksum += i * number
        # println("$i x $number")
      end
      pos += nnum
    end

    if haskey(new_nums, inum)
      for (newnum, nnewnum) in new_nums[inum]
        for i in pos:pos+nnewnum-1
          checksum += i * newnum
          # println("$i x $number")
        end
        pos += nnewnum
      end
    end

    pos += pauses[inum]

  end

  checksum
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(9)
  parsed = parse(input)

  println("Solution Part One: ", @time part_one(parsed))
  @printf("%d\n", part_one(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
  @printf("%d\n", part_two(parsed))
end
