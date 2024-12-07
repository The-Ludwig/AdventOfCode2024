using Test
import AdventOfCode2024 as aoc

test_data = """....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."""

parsed = aoc.Day06.parse(test_data)

@testset "Parse" begin
  @test parsed.width == 10
  @test parsed.height == 10
  @test parsed.guard_pos == (7, 5)
  @test parsed.guard_dir == aoc.Day06.up
  @test (1, 5) in parsed.blocks
end

@testset "Part 1" begin
  @test aoc.Day06.part_one(parsed) == 41
end

@testset "Part 2" begin
  @test aoc.Day06.part_two(parsed) == 6
end
