# DTS–QCA: Two-dimensional X–Y threshold sweep

Sweeps thresholds for multiple X variables and the outcome Y jointly.
For each combination of X thresholds and each candidate Y threshold, the
data are binarized and a crisp-set QCA is executed.

## Usage

``` r
dtSweep(
  dat,
  Yvar,
  Xvars,
  sweep_list_X,
  sweep_range_Y,
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

- sweep_list_X:

  Named list. Each element is a numeric vector of candidate thresholds
  for the corresponding X.

- sweep_range_Y:

  Numeric vector. Candidate thresholds for Y.

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

- `combo_id` — index of the X-threshold combination

- `thrY` — threshold for Y

- `thrX` — character label summarizing the X thresholds

- `expression` — minimized solution expression

- `inclS` — solution consistency

- `covS` — solution coverage

If `return_details = TRUE`, a list with:

- `summary` — the data frame above

- `details` — list of runs with `combo_id`, `thrY`, `thrX_vec`,
  `truth_table`, `solution`

## Examples

``` r
# Load sample data
data(sample_data)

# Define threshold ranges for conditions
sweep_list_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

# Define threshold range for outcome
sweep_range_Y <- 6:8

# Run dual threshold sweep
result <- dtSweep(
  dat = sample_data,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_list_X = sweep_list_X,
  sweep_range_Y = sweep_range_Y
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
#> 
#> 
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
head(result)
#>   combo_id thrY             thrX  expression     inclS      covS
#> 1        1    6 X1=6, X2=6, X3=6       X1*X2 0.8333333 0.4411765
#> 2        1    7 X1=6, X2=6, X3=6       X1*X2 0.8333333 0.4545455
#> 3        1    8 X1=6, X2=6, X3=6 No solution        NA        NA
#> 4        2    6 X1=7, X2=6, X3=6       X1*X2 1.0000000 0.3823529
#> 5        2    7 X1=7, X2=6, X3=6       X1*X2 1.0000000 0.3939394
#> 6        2    8 X1=7, X2=6, X3=6 No solution        NA        NA
```
