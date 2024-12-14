using Test
import AdventOfCode2024 as aoc

test_data = "89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732"

parsed = aoc.Day10.parse(test_data)

@testset "Parse" begin
  @test size(parsed) == (8, 8)
  @test parsed[end, end] == 2
end

@testset "Part 1" begin
  @test aoc.Day10.part_one(parsed) == 36
end

@testset "Part 2" begin
  @test aoc.Day10.part_two(parsed) == 81
end
