using Test
import AdventOfCode2024 as aoc

test_data = """3   4
4   3
2   5
1   3
3   9
3   3"""

parsed = aoc.Day01.parse(test_data)

@testset "Parsing" begin
  @test parsed[1].size == (6,)
  @test parsed[2].size == (6,)
end

@testset "Part 1" begin
  @test aoc.Day01.part_one(parsed...) == 11
end

@testset "Part 2" begin
  # Sort as they would do in part1
  sort!(parsed[1])
  sort!(parsed[2])
  @test aoc.Day01.part_two(parsed...) == 31
end
