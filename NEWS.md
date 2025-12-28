# TSQCA 0.3.0

## New Features

### QCA-Compatible Argument Names
* Renamed `Yvar` to `outcome` and `Xvars` to `conditions` in all sweep functions
  - Follows QCA package naming conventions for consistency
  - Old argument names (`Yvar`, `Xvars`) are still supported with deprecation warnings

### Negated Outcome Support
* Added support for negated outcomes using tilde prefix (e.g., `outcome = "~Y"`)
  - Analyzes conditions sufficient for the absence of the outcome (Y < threshold)
  - Follows QCA package's `truthTable()` convention for negation
  - Works with all sweep functions: `otSweep()`, `dtSweep()`, `ctSweepS()`, `ctSweepM()`

### Enhanced Report Generation
* `generate_report()` now displays "(negated)" indicator when analyzing negated outcomes
* Supports both old and new parameter names for backward compatibility

## Changes

### Argument Names (Backward Compatible)
* `Yvar` → `outcome` (recommended)
* `Xvars` → `conditions` (recommended)
* Using old argument names will trigger a deprecation warning but will continue to work

### Parameter Storage
* `$params` now includes:
  - `outcome`: New argument name (also stores `~Y` notation if negated)
  - `conditions`: New argument name
  - `negate_outcome`: Boolean indicating if outcome was negated

## Migration Guide

```r
# Old syntax (still works, but shows deprecation warning)
result <- otSweep(dat, Yvar = "Y", Xvars = c("X1", "X2"), ...)

# New syntax (recommended)
result <- otSweep(dat, outcome = "Y", conditions = c("X1", "X2"), ...)

# Negated outcome (new feature)
result <- otSweep(dat, outcome = "~Y", conditions = c("X1", "X2"), ...)
```

---

# TSQCA 0.2.0

## New Features

### Multiple Solution Handling
* Added `extract_mode` parameter to all sweep functions (`otSweep()`, `dtSweep()`, `ctSweepS()`, `ctSweepM()`) with three options:
  - `"first"` (default): Returns only the first solution (M1), maintaining backward compatibility
  - `"all"`: Returns all intermediate solutions concatenated (e.g., "M1: A*B; M2: A*C")
  - `"core"`: Returns core conditions common to all solutions, plus peripheral and unique terms

* Added `get_n_solutions()` helper function to count the number of intermediate solutions

### Report Generation
* Added `generate_report()` function for automatic markdown report generation with two formats:
  - `"full"`: Comprehensive report including all analysis details, solution formulas, and fit measures
  - `"simple"`: Condensed format designed for journal manuscript supplementary materials

### Reproducibility
* All sweep functions now return analysis parameters in `$params` for full reproducibility
* Parameters include: variable names, thresholds, QCA settings (`incl.cut`, `n.cut`, `pri.cut`, `dir.exp`, `include`)

## Changes

### Default Value Updates
* Changed `return_details` default from `FALSE` to `TRUE` for better integration with `generate_report()`
* Changed `n.cut` default from `2` to `1` to align with QCA package conventions
* Changed `pri.cut` default from `0.5` to `0` to align with QCA package conventions

### Output Structure
* When `return_details = TRUE`, results are now accessed via `$summary` (e.g., `result$summary$expression`)
* Added `n_solutions` column when using `extract_mode = "all"` or `"core"`
* Added `peripheral_terms` and `unique_terms` columns when using `extract_mode = "core"`

## Documentation

* Updated README with new features section and usage examples
* Added new vignette sections:
  - "Handling Multiple Solutions" explaining core vs. peripheral conditions
  - "Generating Reports" with workflow examples
  - "Best Practices" including computational complexity guidance
* Updated all code examples to reflect new default values and output structure

---
 
# TSQCA 0.1.2

* Initial release for paper submission
* Implemented four threshold sweep methods:
  - `ctSweepS()`: Single-condition X sweep (CTS-QCA)
  - `ctSweepM()`: Multi-condition X sweep (MCTS-QCA)
  - `otSweep()`: Outcome Y sweep (OTS-QCA)
  - `dtSweep()`: Two-dimensional X and Y sweep (DTS-QCA)
* Core QCA functions: `qca_bin()`, `qca_extract()`
* Sample dataset included

---

# TSQCA 0.1.1

* Bug fixes and documentation improvements

---

# TSQCA 0.1.0

* Initial development version
