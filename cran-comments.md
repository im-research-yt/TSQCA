# Submission of ThSQCA 2.0.4

This is a bug fix release for the package currently on CRAN (version 2.0.2).
Version 2.0.3 was prepared but not submitted, so its NEWS entry is included
here.

## Summary of changes

This release corrects which fit measures (consistency `inclS` and coverage
`covS`) are reported alongside a displayed solution.

`QCA::minimize()` stores fit measures in different places depending on the
result: in `$IC$sol.incl.cov` for a single minimal solution, in
`$IC$individual[[k]]` and `$IC$overall` when several minimal solutions are tied,
and in `$i.sol$C1P1$IC` for the intermediate solution when `dir.exp` is used.
Previous versions could read the aggregate value, or the parsimonious value,
while displaying a different solution, so the printed formula and the printed
fit measures did not correspond. The extractors now read the fit of the solution
that is actually displayed, and the report writer passes the matching object at
every call site.

The affected measure is mainly `covS`; `inclS` differs only marginally in the
multiple-solution case, but can differ substantially in the intermediate case.
Crisp-set results, single-solution cells, cells with no solution, and all
solution formulas are unchanged. No computation was altered: only the selection
of which stored value is read.

Regression tests were added for each case, including tests that run
`generate_report()` end to end and parse its output.

## Test environments

* local: Windows 11 x64 (build 26200), R 4.6.0 (2026-04-24 ucrt)
* win-builder: R-devel

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

There are no reverse dependencies on CRAN.
