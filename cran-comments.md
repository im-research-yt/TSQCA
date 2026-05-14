# CRAN Submission Comments — ThSQCA 2.0.0

## Package rename

This package supersedes TSQCA (v1.3.2, currently on CRAN).

The package was renamed from TSQCA to ThSQCA following a reviewer
recommendation to avoid confusion with Time-Series QCA (the prefix
"ts" is the base R class for time-series objects).

All functions (otSweep, ctSweepS, ctSweepM, dtSweep, etc.) and
internal logic are identical to TSQCA v1.3.2. Only the package
name changes.

A deprecated version of TSQCA (v1.3.3) with a startup warning
directing users to ThSQCA will be submitted concurrently.

## Test environments

* Windows 11 x64, R 4.4.2 (local)

## R CMD check results

0 errors | 0 warnings | 1 note

* NOTE: "unable to verify current time" — network-dependent note
  unrelated to the package.

## Downstream dependencies

There are currently no downstream dependencies for this package.
