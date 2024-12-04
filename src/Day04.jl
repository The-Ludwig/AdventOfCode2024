using AdventOfCode2024
using Debugger

function part_one(data)::Int
  word = "XMAS"
  splitted = split(data, "\n")

  count = 0

  # 2 loops: iterate over start of word
  for (i_row, row) in enumerate(splitted)
    for (i_char, char) in enumerate(row)
      # 2 loops: iterate over 8 (+1 lazy) direction
      for dchar in [-1 0 1]
        for drow in [-1 0 1]
          is_word = true
          i_row_loc::Int = i_row
          i_char_loc::Int = i_char

          # iterate over word
          for c in word
            if splitted[i_row_loc][i_char_loc] != c
              is_word = false
              break
            end

            if c != word[end]
              if (1 <= (i_row_loc + drow) <= length(splitted)) && (1 <= (i_char_loc + dchar) <= length(row))
                i_row_loc += drow
                i_char_loc += dchar
              else
                is_word = false
                break
              end
            end
          end

          # add to the count of word
          if is_word
            count += 1
          end

        end
      end
    end
  end

  count
end

function part_two(data)::Int
  splitted = split(data, "\n")

  count = 0

  # 2 loops: iterate over start of word
  for (i_row, row) in enumerate(splitted)
    for (i_char, char) in enumerate(row)
      if !((1<=i_row-1) && (1 <= i_char-1) && (i_char+1 <= length(row)) && (i_row+1 <= length(splitted)))
        continue
      end

      if splitted[i_row][i_char] != 'A'
        continue
      end
      
      pair1 = (splitted[i_row+1][i_char+1], splitted[i_row-1][i_char-1])
      if !('M' in pair1 && 'S' in pair1)
        continue
      end

      pair2 = (splitted[i_row+1][i_char-1], splitted[i_row-1][i_char+1])
      if !('M' in pair2 && 'S' in pair2)
        continue
      end

      count += 1
    end
  end

  count
end



if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(4)

  println("Solution Part One: ", @time part_one(input))
  println("Solution Part Two: ", @time part_two(input))
end
