# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie
using CairoMakie # hide
CairoMakie.activate!() # hide
f = Figure()

for (i, scale) in enumerate([identity, log10, log2, log, sqrt, Makie.logit])
    row, col = fldmod1(i, 2)
    Axis(f[row, col], xscale = scale, title = string(scale),
        xminorticksvisible = true, xminorgridvisible = true,
        xminorticks = IntervalsBetween(5))

    lines!(range(0.01, 0.99, length = 200), 1:200)
end

f
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_f65213e6_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_f65213e6.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
save(joinpath(@OUTPUT, "example_f65213e6.svg"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
nothing # hide