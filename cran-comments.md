# Submission of ThSQCA 2.0.6

This is a bug fix release. A systematic audit of the package, prompted by a
user's bug report, uncovered several defects that fail silently: they return
a plausible but wrong number, or an empty result, with no error or warning.
This is the third bug fix release in a short period; I recognise that this
is not the usual cadence, and I have taken steps (a package-wide audit and
94 new regression tests) to make it the last of the series.

## Changes

Correctness fixes:

* When `dir.exp` produces an intermediate solution spanning several prime
  implicant charts (QCA's `"From C1P1, C2P1:"` case), the number of minimal
  solutions was over-counted, because each chart's `$solution` slot can
  enumerate the same models. The inflated count appeared in
  `result$summary$n_solutions`, in reports, and in configuration charts,
  which also emitted one identical table per duplicate. All affected sites
  now share one enumeration that deduplicates models by their term set.
  The solution expressions and all fit measures were already correct.
* `dtSweep()` and `ctSweepM()` returned an unnamed `details` list, while
  every consumer iterates it by name. For these two functions
  `compute_fiss_core()` therefore returned an empty result and
  `generate_fiss_chart()` reported that no solutions were found even where
  every cell had one; the detailed sections of `generate_report()` came out
  empty. Both functions now return a uniquely named list, and
  `compute_fiss_core()` validates this rather than silently processing
  nothing.
* `generate_report(format = "simple")` reported the fit measures of
  parsimonious and complex solutions as `NA`; the full report was correct.

Input validation (previously silent misbehaviour, now errors or warnings):

* Non-numeric condition or outcome columns were thresholded with R's
  lexicographic `>=` (`"10" >= "7"` is `FALSE`), silently misclassifying
  cases; they are now rejected with an informative error.
* Duplicated sweep values desynchronised `summary` and `details`, so
  positional access matched the wrong cell; duplicates are now dropped with
  a warning.
* A condition without a threshold, an outcome listed among its own
  conditions, an empty data frame, and a `dir.exp` of the wrong length each
  produced a silent "No solution", a tautological solution, or an internal
  R error; each now fails fast with a message stating the problem and the
  fix. A single unnamed `thrX` value now applies to every condition, and
  `thrX` may be omitted when all conditions are pre-calibrated.

Interface:

* `ctSweepM()` gained a `thrX_default` argument, mirroring `ctSweepS()`.
* `print_fiss_summary()` no longer requires `thr_key`; omitting it
  summarises every threshold level.
* Product terms within one solution are now labelled `T1`, `T2`, ... in
  configuration charts and Fiss summaries. `M1`, `M2`, ... previously
  denoted both whole solutions and single terms, which was ambiguous. This
  changes displayed labels only; no computed value is affected.

Regression tests were added for every fix (94 new assertions). Results that
were correct in 2.0.5 are unchanged; this was verified by re-running the
same inputs through both versions and comparing every cell, and by checking
fit measures against hand calculation and against direct calls to
`QCA::truthTable()` and `QCA::minimize()`.

## Test environments

* local: Windows 10 x64, R 4.6.0
* Ubuntu 24.04.4 LTS, R 4.3.3, QCA 3.25

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

There are no reverse dependencies on CRAN.
