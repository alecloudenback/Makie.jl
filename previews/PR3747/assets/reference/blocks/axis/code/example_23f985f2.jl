# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie
using CairoMakie # hide
CairoMakie.activate!() # hide
f = Figure()

Axis(f[1, 1], title = "Title")
Axis(f[2, 1], title = L"\sum_i{x_i \times y_i}")
Axis(f[3, 1], title = rich(
    "Rich text title",
    subscript(" with subscript", color = :slategray)
))

f
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_23f985f2_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_23f985f2.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
save(joinpath(@OUTPUT, "example_23f985f2.svg"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
nothing # hide