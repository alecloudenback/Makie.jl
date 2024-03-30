# This file was generated, do not modify it. # hide
using Makie.LaTeXStrings: @L_str                       # hide
__result = begin                                       # hide
    using CairoMakie
CairoMakie.activate!() # hide

using Random
Random.seed!(1234)

x = randn(50)
y = randn(50)
z = -sqrt.(x .^ 2 .+ y .^ 2) .+ 0.1 .* randn.()

f, ax, tr = tricontourf(x, y, z)
scatter!(x, y, color = z, strokewidth = 1, strokecolor = :black)
Colorbar(f[1, 2], tr)
f
end                                                    # hide
sz = size(Makie.parent_scene(__result))                # hide
open(joinpath(@OUTPUT, "example_b25c1b2f_size.txt"), "w") do io # hide
    print(io, sz[1], " ", sz[2])                       # hide
end                                                    # hide
save(joinpath(@OUTPUT, "example_b25c1b2f.png"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
save(joinpath(@OUTPUT, "example_b25c1b2f.svg"), __result; px_per_unit = 2, pt_per_unit = 0.75, ) # hide
nothing # hide