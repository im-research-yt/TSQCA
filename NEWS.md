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
