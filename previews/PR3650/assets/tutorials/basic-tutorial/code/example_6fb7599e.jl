# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie

fig, ax, hm = heatmap(randn(20, 20))
Colorbar(fig[1, 2], hm)
fig
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_6fb7599e_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_6fb7599e.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
save(joinpath(@OUTPUT, "example_6fb7599e.svg"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
nothing # hide