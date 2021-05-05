"""
    violin(x, y; kwargs...)
Draw a violin plot.
# Arguments
- `x`: positions of the categories
- `y`: variables whose density is computed
# Keywords
- `orientation=:vertical`: orientation of the violins (`:vertical` or `:horizontal`)
- `width=0.8`: width of the violin
- `show_median=true`: show median as midline
- `side=:both`: specify `:left` or `:right` to only plot the violin on one side
- `datalimits`: specify values to trim the `violin`. Can be a `Tuple` or a `Function` (e.g. `datalimits=extrema`)
"""
@recipe(Violin, x, y) do scene
    Theme(;
        default_theme(scene, Poly)...,
        npoints = 200,
        boundary = automatic,
        bandwidth = automatic,
        side = :both,
        width = automatic,
        dodge = automatic,
        n_dodge = automatic,
        x_gap = 0.2,
        dodge_gap = 0.03,
        datalimits = (-Inf, Inf),
        max_density = automatic,
        strokecolor = :white,
        show_median = false,
        mediancolor = automatic,
        medianlinewidth = 1.0,
    )
end

conversion_trait(x::Type{<:Violin}) = SampleBased()

function plot!(plot::Violin)
    x, y = plot[1], plot[2]
    args = @extract plot (width, side, color, show_median, npoints, boundary, bandwidth,
        datalimits, max_density, dodge, n_dodge, x_gap, dodge_gap)
    signals = lift(x, y, args...) do x, y, width, side, color, show_median, n, bound, bw, limits, max_density, dodge, n_dodge, x_gap, dodge_gap
        x̂, violinwidth = xw_from_dodge(x, width, 1, x_gap, dodge, n_dodge, dodge_gap)

        # Allow `side` and `color` to be either scalar or vector
        sides = broadcast(x̂, side) do _, s
            return s == :left ? - 1 : s == :right ? 1 : 0
        end
        colors = broadcast(x̂, color) do _, c
            rgba = to_color(c)
            # `RGBA` values cannot be sorted
            return (rgba.r, rgba.g, rgba.b, rgba.alpha)
        end

        sa = StructArray((x = x̂, side = sides, color = colors))

        specs = map(StructArrays.finduniquesorted(sa)) do (key, idxs)
            v = view(y, idxs)
            k = KernelDensity.kde(v;
                npoints = n,
                (bound === automatic ? NamedTuple() : (boundary = bound,))...,
                (bw === automatic ? NamedTuple() : (bandwidth = bw,))...,
            )
            l1, l2 = limits isa Function ? limits(v) : limits
            i1, i2 = searchsortedfirst(k.x, l1), searchsortedlast(k.x, l2)
            kde = (x = view(k.x, i1:i2), density = view(k.density, i1:i2))
            return (x = key.x, side = key.side, color = RGBA(key.color...), kde = kde, median = median(v))
        end

        max = if max_density === automatic
            maximum(specs) do spec
                _, max = extrema_nan(spec.kde.density)
                return max
            end
        else
            max_density
        end

        vertices = Vector{Point2f0}[]
        lines = Pair{Point2f0, Point2f0}[]
        colors = RGBA{Float32}[]

        for spec in specs
            scale = 0.5*violinwidth/max
            xl = reverse(spec.x .- spec.kde.density .* scale)
            xr = spec.x .+ spec.kde.density .* scale
            yl = reverse(spec.kde.x)
            yr = spec.kde.x

            x_coord, y_coord = if spec.side == -1 # left violin
                [spec.x; xl; spec.x], [yl[1]; yl; yl[end]]
            elseif spec.side == 1 # right violin
                [spec.x; xr; spec.x], [yr[1]; yr; yr[end]]
            else
                [spec.x; xr; spec.x; xl], [yr[1]; yr; yl[1]; yl]
            end
            verts = Point2f0.(x_coord, y_coord)
            push!(vertices, verts)

            if show_median
                # interpolate median bounds between corresponding points
                xm = spec.median
                ip = findfirst(>(xm), spec.kde.x)
                ym₋, ym₊ = spec.kde.density[ip-1], spec.kde.density[ip]
                xm₋, xm₊ = spec.kde.x[ip-1], spec.kde.x[ip]
                ym = (xm * (ym₊ - ym₋) + xm₊ * ym₋ - xm₋ * ym₊) / (xm₊ - xm₋)
                median_left = Point2f0(spec.side == 1 ? spec.x : spec.x - ym * scale, xm)
                median_right = Point2f0(spec.side == -1 ? spec.x : spec.x + ym * scale, xm)
                push!(lines, median_left => median_right)
            end
            push!(colors, spec.color)
        end

        return (vertices = vertices, lines = lines, colors = colors)
    end

    t = copy(Theme(plot))
    mediancolor = pop!(t, :mediancolor)
    t[:color] = lift(s -> s.colors, signals)
    poly!(plot, t, lift(s -> s.vertices, signals))
    linesegments!(
        plot,
        lift(s -> s.lines, signals),
        color = lift(
            (mc, sc) -> mc === automatic ? sc : mc,
            mediancolor,
            plot[:strokecolor],
        ),
        linewidth = plot[:medianlinewidth],
        visible = plot[:show_median],
        inspectable = plot[:inspectable]
    )
end