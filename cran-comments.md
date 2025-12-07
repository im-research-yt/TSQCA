## Test environments
* Windows 11 x64, R 4.4.1

## R CMD check results
0 errors | 0 warnings | 0 notes

## Submission notes
This is a new submission.

The package implements threshold sweep methods for Qualitative Comparative 
Analysis (QCA), which are computationally intensive by nature. 

Long-running examples (dtSweep, ctSweepM) that demonstrate the full 
functionality are wrapped in \donttest{} as they require approximately 
10-15 seconds and 5-8 seconds respectively. Quick demonstrations with 
reduced complexity (< 5 seconds) are provided outside \donttest{} for 
CRAN automated checks.

The package includes comprehensive vignettes in both English and Japanese 
to serve a broader research community.