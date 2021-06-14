# PyPlot examples

?> [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl) examples sourced mostly inspired by this [awesome gist from by gizmaa](https://gist.github.com/gizmaa)

- [Annotations](01-annotation.html)
- [3D surface plot](02-3dsurf.html)
- [Axis placement](03-axisplacement.html)
- [Bar plot](04-barplot.html)
- [Broken Axis](05-brokenaxis.html)
- [Custom time format](06-customtime.html)
- [Error bar](07-errorbar.html)
- [Histogram](08-histogram.html)
- [Inexact plot](09-inexact.html)
- [Line collections](10-linecollection.html)
- [Major and minot tick](11-majorminortick.html)
- [Multiple axis](12-multiaxis.html)
- [Pie chart](13-pie.html)
- [Quiver plot](14-quiver.html)
- [Scatter plot](15-scatter.html)
- [Stream plot](16-streamplot.html)
- [Sublots](17-subplots.html)
- [Surface plot](18-surface.html)
- [Windrose plot](19-windrose.html)


## Translating `matplotlib` commands to `PyPlot.jl` ones

```python
# Python

ax.set_ylim([-30, 10])
ax.spines["right"].set_color("none")
ax.spines["top"].set_color("none")
```

could be translated to

```julia
# Julia

ax.set_ylim([-30, 10])
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
```

## Modifying matplotlib.rcParams

For example, to set the derfault font size to 15:

```julia
rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
rcParams["font.size"] = 15
```