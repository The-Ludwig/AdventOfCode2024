using AdventOfCode2024
using Debugger

Pos = Tuple{Int,Int}
@enum Dir up down left right

struct Board
  antennas::Dict{Char, Vector{Pos}}
  height::Int
  width::Int
end

function parse(input::String)
  antennas = Dict()
  splitted = split(input, "\n")

  for (i_row, row) in enumerate(splitted)
    for (i_char, char) in enumerate(row)
      if char == '.'
        continue
      end

      if !haskey(antennas, char)
        antennas[char] = Vector()
      end

      push!(antennas[char], (i_row, i_char))
    end
  end

  Board(antennas, length(splitted), length(splitted[1]))
end

function in(p::Pos, board)
  (1 <= p[1] <= board.height) && (1 <= p[2] <= board.width)
end

function part_one(board::Board)
  antinodes = Set()
  @debug "$board"

  for (freq, ants) in board.antennas
    @debug "$freq"
    # iterate through every pair of same frequency antennas
    for (idx1, a1) in enumerate(ants)
      for a2 in ants[idx1+1:end]
        dist = a1.-a2
        @debug "$a1-$a2=$dist"
        
        n1 = a1.+dist
        @debug "$n1"
        if n1 in board
          push!(antinodes, n1)
        end

        n2 = a2.-dist
        @debug "$n1"
        if n2 in board
          push!(antinodes, n2)
        end

      end
    end

  end

  length(antinodes)
end

function part_two(board::Board)
  antinodes = Set()
  @debug "$board"

  for (freq, ants) in board.antennas
    @debug "$freq"
    # iterate through every pair of same frequency antennas
    for (idx1, a1) in enumerate(ants)
      for a2 in ants[idx1+1:end]
        dist = a1.-a2
        @debug "$a1-$a2=$dist"
        # ToDo: Reduce fraction...
        
        # dir 1
        pos = a1
        while pos in board
          push!(antinodes, pos)
          pos = pos.+dist
        end

        # dir 2
        pos = a1
        while pos in board
          push!(antinodes, pos)
          pos = pos.-dist
        end
      end
    end

  end

  length(antinodes)
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(8)
  parsed = parse(input)

  println("Solution Part One: ", @time part_one(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
end
