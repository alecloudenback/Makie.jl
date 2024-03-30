# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie
CairoMakie.activate!() # hide


f = Figure()

ax1 = Axis(f[1, 1], title = "Axis 1", ylabel = "y label", ytickformat = "{:.3f}")
ax2 = Axis(f[2, 1], title = "Axis 2", ylabel = "y label", xlabel = "x label")
ax3 = Axis(f[2, 2], title = "Axis 3", xlabel = "x label", xtickformat = "{:.3f}", xticklabelrotation = pi/4)

f
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_9684f534_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_9684f534.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
save(joinpath(@OUTPUT, "example_9684f534.svg"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
nothing # hide