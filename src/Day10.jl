using AdventOfCode2024
using Debugger
using Printf

Field = Array{Int8,2}

struct Pos
  x::Int
  y::Int
end

function parse(input::String)::Field
  stack(row -> Base.parse.(Int8, collect(row)), split(input, "\n"))
end

Base.:+(a::Pos, b::Tuple{Any, Any}) = Pos(a.x+b[1], a.y+b[2])
Base.getindex(f::Field, p::Pos)::Int8 = f[p.x, p.y]
Base.in(p::Pos, f::Field) = (1 <= p.x <= f.size[1]) && (1 <= p.y <= f.size[2])

function get_branches(field::Field, pos::Pos)::Set{Pos}
  branches = Set{Pos}()
  height = field[pos]

  for step in [(1, 0), (0, 1), (-1, 0), (0, -1)]
    new_pos = pos + step

    if !(new_pos in field)
      continue
    end

    if field[new_pos] != height + 1
      continue
    end

    push!(branches, new_pos)
  end

  branches
end

function get_endpoints(field::Field, start_pos::Pos)::Vector{Pos}
  cur_end = Set{Pos}([start_pos])
  ends = []

  while length(cur_end) > 0
    new_ends = Set{Pos}()

    for ce in cur_end
      if field[ce] < 9
        branches = get_branches(field, ce)
        union!(new_ends, branches)
      else
        push!(ends, ce)
      end
    end

    cur_end = new_ends
  end

  ends
end

function get_paths(field::Field, start_pos::Pos)::Vector{Vector{Pos}}
  cur_paths = Set{Vector{Pos}}([[start_pos]])
  finished_paths = []

  while length(cur_paths) > 0
    new_paths = Set{Vector{Pos}}()

    for cp in cur_paths
      if field[cp[end]] < 9
        branches = get_branches(field, cp[end])
        for branch in branches
          path = copy(cp)
          push!(path, branch)
          push!(new_paths, path)
        end
      else
        push!(finished_paths, cp)
      end
    end

    cur_paths = new_paths
  end

  finished_paths
end

function part_one(field::Field)
  startpoints = findall(el -> el == 0, field)

  sum((sp -> length(get_endpoints(field, Pos(sp[1], sp[2])))).(startpoints))
end

function part_two(field::Field)
  startpoints = findall(el -> el == 0, field)

  sum((sp -> length(get_paths(field, Pos(sp[1], sp[2])))).(startpoints))
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(10)
  parsed = parse(input)

  @printf("%d\n", part_one(parsed))
  println("Solution Part One: ", @time part_one(parsed))
  @printf("%d\n", part_two(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
end
