using Test
import AdventOfCode2024 as aoc

test_data = "125 17"

parsed = aoc.Day11.parse(test_data)

@testset "Parse" begin
  @test size(parsed) == (2,)
  @test parsed[1] == 125
  @test parsed[2] == 17
end

@testset "Part 1" begin
  @test aoc.Day11.part_one(parsed) == 55312
end

