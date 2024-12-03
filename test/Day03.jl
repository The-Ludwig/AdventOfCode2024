using Test
import AdventOfCode2024 as aoc

test_data = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

parsed = aoc.Day03.parse(test_data)

@testset "Parsing" begin
  @test parsed.size == (3,)
  @test parsed[1] == (2, 4)
  @test parsed[2] == (5, 5)
  @test parsed[3] == (11, 8)
  @test parsed[4] == (8, 5)
end
#
# @testset "Part 1" begin
#   @test aoc.Day02.part_one(parsed) == 2
# end
#
# @testset "Part 2" begin
#   # complicated border case
#   @test aoc.Day02.part_two([[10, 9, 13, 14, 17, 20]]) == 1
#   @test aoc.Day02.part_two(parsed) == 4
# end
