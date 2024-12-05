using Test
import AdventOfCode2024 as aoc

test_data = """47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"""

parsed = aoc.Day05.parse(test_data)

@testset "Parse" begin
  @test parsed[1][2][1] == 97
  @test parsed[1][2][2] == 13
  @test parsed[2][2][end] == 13
end

@testset "Part 1" begin
  @test aoc.Day05.part_one(parsed...) == 143
end

@testset "Part 2" begin
  @test aoc.Day05.part_two(parsed...) == 123
end
