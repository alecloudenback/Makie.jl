# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie
CairoMakie.activate!() # hide


f = Figure()
Axis(f[1, 1])

ecdfplot!(randn(200))

f
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_d2003b83_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_d2003b83.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
 # hide
nothing # hide