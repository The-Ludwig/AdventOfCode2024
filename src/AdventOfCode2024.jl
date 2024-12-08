module AdventOfCode2024

export get_input, plot_time

using Downloads: download, request
using Plots
using DelimitedFiles

function get_input(day::Int, year::Int=2024)::String
    # cache input
    cachefile = ".cache/day$day.input"

    # create dir if it does not exist
    mkpath(".cache/")

    # download and cache if input does not already exist
    if !isfile(cachefile)
      url = "https://adventofcode.com/$year/day/$day/input"
      session = strip(read(".session", String))
      headers = ["Cookie" => "session=$session"]
      download(url, cachefile; headers = headers)
    end 

    strip(read(cachefile, String))
end

function plot_time(file="times.txt")
  bg = RGB(0.2, 0.2, 0.2)
  # Load data
  data = readdlm(file, Float32, comments=true)
  day = @view data[:,1]
  time1 = @view data[:,2]
  timesum = @view data[:,3]

  # plot solving time
  plot(day, [time1 timesum-time1 timesum], mark=[:star6 :star7 :star8], markerstrokecolor=[1 2 3], label=["Part 1" "Part 2" "Total"], bg=bg)

  xlabel!("Day")
  ylabel!("Time / minutes")
  title!("Time spend on puzzles")
  xlims!(1, maximum(day)+1)
  ylims!(0, maximum(timesum)*1.1)
  
  savefig("time.png")
  
  # plot runtime
  runtime1 = @view data[:,4]
  runtime2 = @view data[:,5]
  plot(day, [runtime1 runtime2], mark=[:star6 :star7], label=["Part 1" "Part 2"], markerstrokecolor=[1 2], bg=bg, yscale=:log10)

  xlabel!("Day")
  ylabel!("Runime / ms")
  title!("Runtime Solutions")
  xlims!(1, maximum(day)+1)
  ylims!(0.05, maximum(vcat(runtime1, runtime2))*1.1)
  
  savefig("runtime.png")
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

if abspath(PROGRAM_FILE) == @__FILE__
  plot_time()
end

end # module AdventOfCode2024
