## R CMD check results
0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Yuki Toyoda <yuki.toyoda.ds@hosei.ac.jp>'

## Resubmission
This is an update from version 1.0.0 to 1.1.0.

## Changes in this version

### Bug Fix (Critical)
* Fixed `dir.exp = NULL` handling: In v1.0.0, `dir.exp = NULL` was incorrectly 
  converted to `c(1, 1, ...)`, forcing intermediate solution calculation. 
  Now correctly passed to `QCA::minimize()` without modification.

### Breaking Changes
* Default arguments now match QCA package:

  - `include`: Changed from `"?"` to `""` (complex solution by default)
  - `dir.exp`: Now correctly preserved as `NULL` (no directional expectations)

* This means TSQCA now produces **complex solutions** by default, 
  matching `QCA::minimize()` default behavior.

### Documentation
* Added comprehensive examples showing all three solution types 
  (complex, parsimonious, intermediate) in vignettes and function documentation.
* Updated NEWS.md with migration guide for users upgrading from v1.0.0.

See NEWS.md for full details.

## Test environments
* Local: Windows 11 x64, R 4.4.2

## Downstream dependencies
There are currently no downstream dependencies for this package.