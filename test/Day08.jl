using Test
import AdventOfCode2024 as aoc

test_data = """............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............"""

parsed = aoc.Day08.parse(test_data)

@testset "Parse" begin
  @test parsed.width == 12
  @test parsed.height == 12
  @test parsed.antennas['0'][1] == (2, 9)
  @test parsed.antennas['A'][end] == (10, 10)
end

@testset "Part 1" begin
  @test aoc.Day08.part_one(parsed) == 14
end

@testset "Part 2" begin
  @test aoc.Day08.part_two(parsed) == 34
end
