using Test
import AdventOfCode2024 as aoc
using Debugger

test_data = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
test_data_2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

parsed = aoc.Day03.parse(test_data)

@testset "Parsing" begin
  @test parsed.size == (4,)
  @test parsed[1] == (2, 4)
  @test parsed[2] == (5, 5)
  @test parsed[3] == (11, 8)
  @test parsed[4] == (8, 5)
end

@testset "Part 1" begin
  @test aoc.Day03.part_one(parsed) == 161
end

@testset "Part 2" begin
  @test aoc.Day03.part_two(test_data_2) == 48
end
