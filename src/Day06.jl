using AdventOfCode2024
using Debugger

Pos = Tuple{Int,Int}
@enum Dir up down left right

struct Board
  guard_dir::Dir
  guard_pos::Pos
  blocks::Vector{Pos}
  height::Int
  width::Int
end

function parse(char::Char)::Dir
  if char == '^'
    return up
  elseif char == '>'
    return right
  elseif char == 'v'
    return down
  elseif char == '<'
    return left
  end

  throw(ArgumentError("Char $char is not a valid direction."))

end

function step(dir::Dir)
  if dir == up
    return (-1, 0)
  elseif dir == down
    return (1, 0)
  elseif dir == left
    return (0, -1)
  elseif dir == right
    return (0, 1)
  end
end

function turn_right(dir::Dir)
  if dir == up
    return right
  elseif dir == down
    return left
  elseif dir == left
    return up
  elseif dir == right
    return down
  end
end

function parse(input::String)
  blocks = Vector{Pos}()
  local guard_dir, guard_pos
  splitted = split(input, "\n")

  for (i_row, row) in enumerate(splitted)
    for (i_char, char) in enumerate(row)
      if char == '#'
        push!(blocks, (i_row, i_char))
      elseif char in ('^', '>', 'v', '<')
        guard_dir = parse(char)
        guard_pos = (i_row, i_char)
      end
    end
  end

  Board(guard_dir, guard_pos, blocks, length(splitted), length(splitted[1]))
end

function get_visited(board::Board)
  visited = Set()
  pos = board.guard_pos
  dir = board.guard_dir

  while (1 <= pos[1] <= board.height) && (1 <= pos[2] <= board.width)
    push!(visited, pos)
    st = step(dir)
    next_pos = pos .+ st

    if next_pos in board.blocks
      dir = turn_right(dir)
      continue
    end

    pos = next_pos
  end

  visited
end

function part_one(board::Board)
  length(get_visited(board))
end

function is_loop(board::Board)
  turnpoints = Set()
  pos = board.guard_pos
  dir = board.guard_dir

  while (1 <= pos[1] <= board.height) && (1 <= pos[2] <= board.width)
    st = step(dir)
    next_pos = pos .+ st

    if next_pos in board.blocks
      if (pos, dir) in turnpoints
        return true
      end
      push!(turnpoints, (pos, dir))

      dir = turn_right(dir)
      continue
    end

    pos = next_pos
  end

  false
end

function part_two(board::Board)
  loops = 0

  visited = get_visited(board)
  for (i_row, i_char) in visited
    if (i_row, i_char) in board.blocks
      continue
    end

    if (i_row, i_char) == board.guard_pos
      continue
    end

    blocks = copy(board.blocks)
    push!(blocks, (i_row, i_char))

    new_board = Board(board.guard_dir, board.guard_pos, blocks, board.height, board.width)

    if is_loop(new_board)
      loops += 1
    end
  end

  return loops
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(6)
  parsed = parse(input)

  println("Solution Part One: ", @time part_one(parsed))
  println("Solution Part Two: ", @time part_two(parsed))
end
