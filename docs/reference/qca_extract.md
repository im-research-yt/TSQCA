# Extract solution information from a QCA minimization result

Internal helper to obtain the solution expression, consistency (`inclS`)
and coverage (`covS`) from an object returned by
[`QCA::minimize()`](https://rdrr.io/pkg/QCA/man/minimize.html).

## Usage

``` r
qca_extract(sol)
```

## Arguments

- sol:

  A solution object returned by
  [`QCA::minimize()`](https://rdrr.io/pkg/QCA/man/minimize.html).

## Value

A list with elements `expression`, `inclS`, `covS`. If extraction fails,
returns `"No solution"` and `NA_real_` for the numeric values.
