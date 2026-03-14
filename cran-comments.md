# CRAN Submission Comments — TSQCA 1.3.2

## Resubmission note

We apologize for the short interval since the v1.3.1 release (2026-02-18).
This release adds a substantive new feature — Fiss (2011) core/peripheral
condition classification — which was identified as a methodologically
important gap immediately after v1.3.1 was published. No existing code or
behavior has been changed.

## New in this release

### Fiss (2011) Core/Peripheral Classification

Three new exported functions:

- `compute_fiss_core()`: Augments any sweep result with core/peripheral
  classification by comparing the stored intermediate solution to a
  re-computed parsimonious solution at each threshold.
- `generate_fiss_chart()`: Generates Markdown-formatted configuration
  charts using four symbols (core present/absent, peripheral present/absent)
  following Fiss (2011, AMJ).
- `print_fiss_summary()`: Prints a human-readable per-threshold breakdown.

`generate_report()` gains `include_fiss_core = FALSE` (default) which
activates four-symbol charts when set to TRUE on an augmented result.

### Documentation

- New vignette sections in both `TSQCA_Tutorial_EN.Rmd` and
  `TSQCA_Reproducible_EN.Rmd` covering the Fiss workflow end-to-end.
- New man pages: `compute_fiss_core.Rd`, `generate_fiss_chart.Rd`,
  `print_fiss_summary.Rd`, `SYMBOL_SETS_FISS.Rd`.
- Updated `generate_report.Rd` with `include_fiss_core` parameter.

## Test environments

* Windows 11 x64, R 4.4.2 (local)
* R-hub (multiple platforms)

## R CMD check results

0 errors | 0 warnings | 1 note

* NOTE: "unable to verify current time" — network-dependent note
  unrelated to the package.

## Downstream dependencies

There are currently no downstream dependencies for this package.
