# CTS–QCA: Single-condition threshold sweep

Performs a threshold sweep for one focal condition X. For each threshold
in `sweep_range`, the outcome Y and all X variables are binarized using
user-specified thresholds, and a crisp-set QCA is executed.

## Usage

``` r
ctSweepS(
  dat,
  Yvar,
  Xvars,
  sweep_var,
  sweep_range,
  thrY,
  thrX_default = 7,
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

- sweep_var:

  Character. Name of the condition to be swept. Must be one of `Xvars`.

- sweep_range:

  Numeric vector. Candidate thresholds for `sweep_var`.

- thrY:

  Numeric. Threshold for Y (fixed).

- thrX_default:

  Numeric. Default threshold for non-swept X variables.

- dir.exp:

  Optional named numeric vector of directional expectations for
  [`minimize`](https://rdrr.io/pkg/QCA/man/minimize.html). If `NULL`,
  all set to 1.

- include:

  Inclusion rule for `minimize` (e.g., `"?"`).

- incl.cut:

  Consistency cutoff for
  [`truthTable`](https://rdrr.io/pkg/QCA/man/truthTable.html).

- n.cut:

  Frequency cutoff for `truthTable`.

- pri.cut:

  PRI cutoff for `minimize`.

- return_details:

  Logical. If `TRUE`, returns both a summary data frame and detailed
  objects for each threshold.

## Value

If `return_details = FALSE`, a data frame with columns:

- `threshold` — swept threshold for `sweep_var`

- `expression` — minimized solution expression

- `inclS` — solution consistency

- `covS` — solution coverage

If `return_details = TRUE`, a list with:

- `summary` — the data frame above

- `details` — per-threshold list of `threshold`, `thrX_vec`,
  `truth_table`, `solution`

## Examples

``` r
# Load sample data
data(sample_data)

# Run single condition threshold sweep on X3
result <- ctSweepS(
  dat = sample_data,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_var = "X3",
  sweep_range = 6:8,
  thrY = 7,
  thrX_default = 7
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
head(result)
#>   threshold expression   inclS      covS
#> 1         6      X1*X2 1.00000 0.3030303
#> 2         7 X3 + X1*X2 0.90625 0.8787879
#> 3         8 X3 + X1*X2 1.00000 0.8181818
```
