## R CMD check results

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Yuki Toyoda <yuki.toyoda.ds@hosei.ac.jp>'

## Resubmission

This is an update from version 0.1.2 to 1.0.0.

## Changes in this version

Major changes since 0.1.2:

* Added S3 class system with print() and summary() methods for all result types
* Added generate_report() function for automatic markdown report generation
* Added Fiss-style configuration chart functions (generate_config_chart(), etc.)
* Added support for negated outcomes using tilde prefix (e.g., outcome = "~Y")
* Added extract_mode parameter for handling multiple equivalent solutions
* Renamed arguments from Yvar/Xvars to outcome/conditions for QCA package consistency
* Changed default chart_level from "summary" to "term" (Fiss-style format)
* Corrected terminology: "core" to "essential" for Essential Prime Implicants

See NEWS.md for full details.

## Test environments

* Local: Windows 11 x64, R 4.4.1

## Downstream dependencies

There are currently no downstream dependencies for this package.