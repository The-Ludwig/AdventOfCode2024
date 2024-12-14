using Test
import AdventOfCode2024 as aoc

test_data = "2333133121414131402"
parsed = aoc.Day09.parse(test_data)

@testset "Parse" begin
  @test parsed[1] == 2
  @test parsed[end] == 2
end

@testset "Part 1" begin
  @test aoc.Day09.part_one(parsed) == 1928
end

@testset "Part 2" begin
  @test aoc.Day09.part_two(parsed) == 2858
end
