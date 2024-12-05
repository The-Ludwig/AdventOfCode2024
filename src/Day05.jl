using AdventOfCode2024
using Debugger

Rule = Tuple{Int, Int}
Numbers = Vector{Int}

function parse(input::String)::Tuple{Vector{Rule}, Vector{Numbers}}
  rules, numbers = split(input, "\n\n") 

  rules = (row->tuple(Base.parse.(Int, split(row, "|"))...)).(split(strip(rules), "\n"))
  numbers = (row->Base.parse.(Int, split(row, ","))).(split(strip(numbers), "\n"))

  rules, numbers
end

function obeys_rule(numbers::Numbers, rules::Vector{Rule})
  rule_dict = Dict{Int, Vector{Int}}()

  for rule in rules
    if !haskey(rule_dict, rule[1])
      rule_dict[rule[1]] = [rule[2],]
      continue
    end
    push!(rule_dict[rule[1]], rule[2])
  end

  for (idx, num) in enumerate(numbers)
    for num2 in numbers[begin:idx-1]
      # if this is true, the rule is violated!
      if (haskey(rule_dict, num)) && (num2 in rule_dict[num])
        return false
      end
    end

  end

  true
end

function part_one(rules::Vector{Rule}, numbers::Vector{Numbers})
  sum((numbers->numbers[div(length(numbers), 2)+1]).(filter(nums->obeys_rule(nums, rules), numbers)))
end

function order_to_rule(numbers::Numbers, rules::Vector{Rule})
  rule_dict = Dict{Int, Vector{Int}}()

  for rule in rules
    if !haskey(rule_dict, rule[1])
      rule_dict[rule[1]] = [rule[2],]
      continue
    end
    push!(rule_dict[rule[1]], rule[2])
  end

  sort(numbers, lt=(x, y)->(haskey(rule_dict, y)) && (x in rule_dict[y]))
end

function part_two(rules::Vector{Rule}, numbers::Vector{Numbers})
  sum((numbers->order_to_rule(numbers, rules)[div(length(numbers), 2)+1]).(filter(nums->!obeys_rule(nums, rules), numbers)))
end

if abspath(PROGRAM_FILE) == @__FILE__
  input = get_input(5)
  parsed = parse(input)

  println("Solution Part One: ", @time part_one(parsed...))
  println("Solution Part Two: ", @time part_two(parsed...))
end
