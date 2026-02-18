## CRAN Submission: TSQCA 1.3.0

### Summary of changes from v1.2.0

This release adds the Pre-Calibrated Variable Pass-Through (PCVP) feature,
which allows researchers to use fuzzy-set membership scores (pre-calibrated
via QCA::calibrate()) for some conditions while still sweeping others on
their original scale. This enables mixed crisp/fuzzy analyses in all four
sweep functions.

Specific changes:
- New `pre_calibrated` argument in `otSweep()`, `dtSweep()`, `ctSweepS()`,
  and `ctSweepM()`. Variables listed in `pre_calibrated` are passed through
  to `QCA::truthTable()` without binarization. Default is `NULL`, which
  preserves v1.2.0 behavior (full backward compatibility).
- New internal helpers `prepare_dat_bin()` and `validate_pre_calibrated()`
  in `tsqca_core.R`, centralizing data preparation logic.
- `generate_report()` now displays pre-calibrated conditions in the
  Analysis Overview section.
- Vignette `TSQCA_Tutorial_EN.Rmd` updated with new sections explaining
  the `pre_calibrated` argument and guidance on choosing sweep variables.

### Test environments

- Windows 11 x64, R 4.4.2 (local)
- win-builder (planned before submission)

### R CMD check results

0 errors | 0 warnings | 1 note

The NOTE is:
  checking for future file timestamps ... unable to verify current time

This NOTE is due to a network restriction in the local build environment
and is not related to the package itself. It is expected to be absent on
CRAN infrastructure.

### Downstream dependencies

There are no known downstream packages that depend on TSQCA on CRAN.

### Response to previous CRAN review (if any)

This is a new version submission. No previous CRAN review comments are
outstanding.
