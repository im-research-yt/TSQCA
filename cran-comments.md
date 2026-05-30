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

---

## Resubmission (2nd)

Addressed issues raised by CRAN team (Konstanze Lauseker):

1. Removed single quotes around acronyms in DESCRIPTION.
   Quotes are now used only around package/software names
   ('QCA', 'TSQCA') as required by CRAN policy.

2. Replaced \dontrun{} with \donttest{} in all examples
   (ThSQCA-package.R, tsqca_config_chart.R, tsqca_fiss_core.R,
   tsqca_report.R). The examples are executable but may take
   more than 5 seconds.

3. Fixed generate_report() to write output to tempdir() by default
   instead of the user's working directory (R/tsqca_report.R).
   All examples now use file.path(tempdir(), ...) as the output path.

---

## Resubmission (3rd)

Following further review by Konstanze Lauseker, who noted that
\dontrun{} was still present in some examples:

Rather than adding comments explaining why the examples could not
be run, we have removed those examples entirely. The removed
examples were illustrative-only and used undefined objects or
placeholder data not included in the package. All remaining
functionality is demonstrated by the other examples using the
bundled sample_data dataset.

Removed examples:
- generate_config_chart: used undefined 'data' object and
  placeholder conditions not in sample_data
- print_fiss_summary: used undefined object 'res'
- generate_report (Fiss core example): required a specific
  otSweep() configuration not shown in the example

There are now zero \dontrun{} instances in the package.
