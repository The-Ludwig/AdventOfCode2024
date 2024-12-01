module AdventOfCode2024

export get_input

using Downloads: download, request

function get_input(part::Int, day::Int, year::Int=2024)::String
    # cache input
    cachefile = ".cache/day$day.input"

    # download and cache if input does not already exist
    if !isfile(cachefile)
      url = "https://adventofcode.com/$year/day/$day/input"
      session = strip(read(".session", String))
      headers = ["Cookie" => "session=$session"]
      download(url, cachefile; headers = headers)
    end 

    read(cachefile, String)
end


###############################################################
# automatically include all days into this module as submodules
###############################################################
using Glob
this_dir = dirname(@__FILE__)

# find all dayXX.jl files
files = glob("Day*.jl", this_dir)

for file in files
  # name the module like the file without the extension
  module_name = splitext(basename(file))[1]
  mod_symbol = Symbol(module_name)
  @eval(
    module $mod_symbol
      include(joinpath($this_dir, $file))  # Include the file
    end
  )
end

end # module AdventOfCode2024
