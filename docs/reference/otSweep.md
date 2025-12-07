# OTS–QCA: Outcome threshold sweep

Sweeps the threshold of the outcome Y while keeping the thresholds of
all X conditions fixed.

## Usage

``` r
otSweep(
  dat,
  Yvar,
  Xvars,
  sweep_range,
  thrX,
  dir.exp = NULL,
  include = "?",
  incl.cut = 0.8,
  n.cut = 2,
  pri.cut = 0.5,
  return_details = FALSE
)
```

## Arguments

- dat:

  Data frame containing the outcome and condition variables.

- Yvar:

  Character. Outcome variable name.

- Xvars:

  Character vector. Names of condition variables.

- sweep_range:

  Numeric vector. Candidate thresholds for Y.

- thrX:

  Named numeric vector. Fixed thresholds for X variables, with names
  matching `Xvars`.

- dir.exp:

  Directional expectations for `minimize`. If `NULL`, all set to 1.

- include:

  Inclusion rule for `minimize`.

- incl.cut:

  Consistency cutoff for `truthTable`.

- n.cut:

  Frequency cutoff for `truthTable`.

- pri.cut:

  PRI cutoff for `minimize`.

- return_details:

  Logical. If `TRUE`, returns both summary and detailed objects.

## Value

If `return_details = FALSE`, a data frame with columns:

- `thrY` — threshold for Y

- `expression` — minimized solution expression

- `inclS` — solution consistency

- `covS` — solution coverage

If `return_details = TRUE`, a list with:

- `summary` — the data frame above

- `details` — per-Y-threshold list of `thrY`, `thrX_vec`, `truth_table`,
  `solution`

## Examples

``` r
# Load sample data
data(sample_data)

# Set fixed thresholds for conditions
thrX <- c(X1 = 7, X2 = 7, X3 = 7)

# Run outcome threshold sweep
result <- otSweep(
  dat = sample_data,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX = thrX
)
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> Warning: Function writePrimeimp() is deprecated, use writePIs().
#> 
#> 
head(result)
#>   thrY  expression   inclS      covS
#> 1    6  X3 + X1*X2 0.90625 0.8529412
#> 2    7  X3 + X1*X2 0.90625 0.8787879
#> 3    8 No solution      NA        NA
#> 4    9 No solution      NA        NA
```
