using Test
import AdventOfCode2024 as aoc

test_data = "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX"

@testset "Part 1" begin
  @test aoc.Day04.part_one(test_data) == 18
end

@testset "Part 2" begin
  @test aoc.Day04.part_two(test_data) == 9
end
