# Submission of ThSQCA 2.0.5

This is a bug fix release. It follows 2.0.4 immediately because 2.0.4
introduced a regression, and I would rather correct it than leave it on CRAN.
I apologise for the very short interval between submissions.

## Changes

* Fixes a regression in 2.0.4: in cells where the intermediate solution had
  several tied minimal solutions, the consistency and coverage measures were
  reported as `NA`. They are reported correctly again.
* Corrects the core/peripheral classification in `compute_fiss_core()` when the
  parsimonious solution has several tied minimal solutions. A condition is now
  treated as a core condition only where all of those solutions agree.
* Adds a warning when a solution is found but no fit measures can be located
  for it, so that an `NA` is never left unexplained.
* Adds regression tests for both cases.

Results that were correct in 2.0.4 are unchanged. This was checked by running
the same inputs through 2.0.2, 2.0.4 and 2.0.5 and comparing every cell.

## Test environments

* local: Windows 10 x64, R 4.6.0

## R CMD check results

0 errors | 0 warnings | 0 notes

On CRAN's incoming checks a "Days since last update" NOTE is expected, because
2.0.4 was published on 2026-07-23 and this release corrects the regression
described above.

## Reverse dependencies

There are no reverse dependencies on CRAN.
