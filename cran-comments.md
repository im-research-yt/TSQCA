# CRAN Submission Comments — TSQCA 1.3.1

## Resubmission note

We apologize for the short interval since the v1.3.0 release 
(published 2026-01-08). This patch release addresses documentation-only 
issues that we identified shortly after publication. No code logic has 
been changed.

Specifically:

1. **Vignette correction**: Removed a code example in the 
   `pre_calibrated` tutorial section that referenced variables not 
   included in the bundled sample dataset (`sample_data`). The code 
   block was marked `eval=FALSE` and thus did not cause runtime errors, 
   but it was misleading to users who attempted to reproduce it. The 
   section now provides a prose description of the feature only, with a 
   note that a worked example will be added when a suitable public 
   dataset becomes available.

2. **Documentation clarification**: Corrected the `@param` documentation 
   for `thrX`, `thrX_default`, `sweep_list`, and `sweep_list_X` across 
   all four sweep functions (`otSweep`, `ctSweepS`, `ctSweepM`, 
   `dtSweep`). The previous documentation incorrectly stated that 
   pre-calibrated variables require a `thrX` entry. In fact, the 
   implementation has never required this; only the documentation was 
   inaccurate.

We understand that frequent resubmissions are undesirable and will take 
greater care to catch documentation issues before future releases. Thank 
you for your time and patience.

## Test environments

* Windows 11 x64, R 4.4.2 (local)
* R-hub (multiple platforms)

## R CMD check results

0 errors | 0 warnings | 1 note

* NOTE: "unable to verify current time" — this is a network-dependent 
  note unrelated to the package.

## Downstream dependencies

There are currently no downstream dependencies for this package.
