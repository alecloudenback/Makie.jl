# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie
using CairoMakie # hide
CairoMakie.activate!() # hide
f = Figure()

ax1 = Axis(f[1, 1], autolimitaspect = nothing)
ax2 = Axis(f[1, 2], autolimitaspect = 1)

for ax in [ax1, ax2]
    lines!(ax, 0..10, sin)
end

f
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_d57f960d_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_d57f960d.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
save(joinpath(@OUTPUT, "example_d57f960d.svg"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
nothing # hide