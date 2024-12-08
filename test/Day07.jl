using Test
import AdventOfCode2024 as aoc

test_data = """190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20"""

parsed = aoc.Day07.parse(test_data)

@testset "Parse" begin
  @test parsed[1][1] == 190
  @test parsed[end][1] == 292
  @test parsed[end][2][end] == 20
  @test parsed[1][2][2] == 19
end

@testset "Part 1" begin
  @test aoc.Day07.part_one(parsed) == 3749
end

@testset "Part 2" begin
  @test aoc.Day07.part_two(parsed) == 11387
end
