using Test
import AdventOfCode2024 as aoc

test_data = """7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"""

parsed = aoc.Day02.parse(test_data)

@testset "Parsing" begin
  @test parsed.size == (6,)
  for row in parsed
    @test row.size == (5,)
  end
end

@testset "Part 1" begin
  @test aoc.Day02.part_one(parsed) == 2
end

@testset "Part 2" begin
  # complicated border case
  @test aoc.Day02.part_two([[10, 9, 13, 14, 17, 20]]) == 1
  @test aoc.Day02.part_two(parsed) == 4
end
