using Glob
using Test 
this_dir = dirname(@__FILE__)

# find all dayXX.jl files
files = glob("Day*.jl", this_dir)

for file in files
  @testset "$file" begin
    include("$file")
  end
end


