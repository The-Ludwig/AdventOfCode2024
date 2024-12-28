using AdventOfCode2024
using Debugger
using Printf

Field = Array{Char,2}

struct Pos
  x::Int
  y::Int
end

function parse(input::String)::Field
  stack(row -> collect(row), split(input, "\n"))
end

Base.:+(a::Pos, b::Tuple{Any, Any}) = Pos(a.x+b[1], a.y+b[2])
Base.getindex(f::Field, p::Pos)::Char = f[p.x, p.y]
Base.in(p::Pos, f::Field) = (1 <= p.x <= f.size[1]) && (1 <= p.y <= f.size[2])

function get_region_and_perim(field::Field, pos::Pos, dirs=[(1, 0), (0, 1), (-1, 0), (0, -1)])::Tuple{Set{Pos}, Vector{Pos}}
  region = Set{Pos}([pos])
  perim = []

  kind = field[pos]
  to_visit = [pos]

  while length(to_visit) > 0
    cur = pop!(to_visit)

    for step in dirs
      new_pos = cur + step

      if !(new_pos in field)
        push!(perim, new_pos+(1, 1))
        # @debug ("$cur: $perim")
        continue
      end

      if field[new_pos] != kind
        push!(perim, new_pos+(1, 1))
        # @debug ("$cur: $perim")
        continue
      end

      if new_pos in region
        continue
      end

      push!(to_visit, new_pos)
      push!(region, new_pos)
    end
  end

  region, perim
end

function part_one(field::Field)
  # @debug (field)
  all_regions = Set()
  sum = 0

  for x in 1:field.size[1]
    for y in 1:field.size[2]
      pos = Pos(x, y)
      if pos in all_regions
        continue
      end

      region, perim = get_region_and_perim(field, pos)
      sum += length(perim)*length(region)
      fv = field[pos]
      @debug "Region $(fv) with price $(length(region))*$(length(perim))=$(length(perim)*length(region))"

      union!(all_regions, region)
    end
  end

  sum
end

function get_regions(field::Field, ignore='X')
  # @debug (field)
  all_regions_horiz = Set()
  all_regions_vert = Set()
  num = 0

  for x in 1:field.size[1]
    for y in 1:field.size[2]
      pos = Pos(x, y)
      if field[pos] == ignore
        continue
      end

      if !(pos in all_regions_horiz)
        region, _perim = get_region_and_perim(field, pos, [(1, 0), (-1, 0)])
        if length(region) > 1
          num += 1
          union!(all_regions_horiz, region)
        end
      end

      if !(pos in all_regions_vert)
        region, _perim = get_region_and_perim(field, pos, [(0, 1), (0, -1)])
        if (length(region) > 1) || (!(collect(region)[1] in all_regions_horiz))
          num += 1
        end
        union!(all_regions_vert, region)
      end
    end
  end

  num+2
end

function part_two(field::Field)
  # @debug (field)
  all_regions = Set()
  sum = 0

  for x in 1:field.size[1]
    for y in 1:field.size[2]
      pos = Pos(x, y)
      if pos in all_regions
        continue
      end

      region, perim = get_region_and_perim(field, pos)
      
      side_field = fill('X', field.size[1]+2, field.size[2]+2)
      for pp in perim
        side_field[pp.x, pp.y] = 'O'
      end

      for i in 1:side_field.size[1]
        for j in 1:side_field.size[2]
          print("$(side_field[i, j])")
        end
        print("\n")
      end


      sides = get_regions(side_field)
      
      sum += sides*length(region)
      fv = field[pos]
      @debug "Region $(fv) with price $(length(region))*$((sides))=$((sides)*length(region))"



      union!(all_regions, region)
    end
  end

  sum
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(12)
  parsed = parse(input)

  @printf("%d\n", part_one(parsed))
  println("Solution Part One: ", @time part_one(parsed))
  @printf("%d\n", part_two(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
end
