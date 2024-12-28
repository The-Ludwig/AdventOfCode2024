using Test
import AdventOfCode2024 as aoc

test_data = "RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE"

parsed = aoc.Day12.parse(test_data)

@testset "Parse" begin
  @test size(parsed) == (10, 10)
  @test parsed[end, end] == 'E'
end

@testset "Part 1" begin
  @test aoc.Day12.part_one(parsed) == 1930
end

@testset "Part 2" begin
  @test aoc.Day12.part_two(parsed) == 1206
end
