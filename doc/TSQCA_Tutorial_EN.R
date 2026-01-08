## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(TSQCA)
data("sample_data")
dat <- sample_data
str(dat)

## -----------------------------------------------------------------------------
Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

## ----eval=FALSE---------------------------------------------------------------
# # CORRECT: Specify threshold explicitly for each variable
# sweep_list <- list(
#   X1 = 1,      # Binary variable: use threshold 1
#   X2 = 6:8,    # Continuous: sweep thresholds
#   X3 = 6:8     # Continuous: sweep thresholds
# )
# 
# res_mixed <- ctSweepM(
#   dat            = dat,
#   Yvar           = "Y",
#   Xvars          = c("X1", "X2", "X3"),
#   sweep_list     = sweep_list,
#   thrY           = 7,
#   dir.exp        = 1
# )

## ----eval=FALSE---------------------------------------------------------------
# # WRONG: Using sweep range for binary variables
# sweep_list <- list(
#   X1 = 6:8,    # All values become 0 (since 0 < 6 and 1 < 6)
#   X2 = 6:8,
#   X3 = 6:8
# )

## ----eval=FALSE---------------------------------------------------------------
# # Check variable ranges
# summary(dat[, c("X1", "X2", "X3")])
# 
# # Identify binary variables (only 0 and 1)
# sapply(dat[, c("X1", "X2", "X3")], function(x) {
#   unique_vals <- sort(unique(x))
#   if (length(unique_vals) == 2 && all(unique_vals == c(0, 1))) {
#     "Binary (use threshold = 1)"
#   } else {
#     paste("Continuous (range:", min(x), "-", max(x), ")")
#   }
# })

## ----error=TRUE---------------------------------------------------------------
try({
sweep_var   <- "X3"   # Condition (X) whose threshold is swept
sweep_range <- 6:9    # Candidate threshold values to evaluate

thrY         <- 7     # Outcome (Y) threshold (fixed)
thrX_default <- 7     # Threshold for other X conditions (fixed)

res_cts <- ctSweepS(
  dat            = dat,
  Yvar           = "Y",
  Xvars          = c("X1", "X2", "X3"),
  sweep_var      = sweep_var,
  sweep_range    = sweep_range,
  thrY           = thrY,
  thrX_default   = thrX_default,
  dir.exp        = 1,
  return_details = TRUE
)

head(res_cts$summary)
})

## ----error=TRUE---------------------------------------------------------------
try({
res_mcts <- ctSweepM(
  dat            = dat,
  Yvar           = "Y",
  Xvars          = c("X1", "X2", "X3"),
  sweep_vars     = c("X2", "X3"),
  sweep_range    = 6:9,
  thrY           = 7,
  thrX_default   = 7,
  dir.exp        = 1,
  return_details = TRUE
)

head(res_mcts$summary)
})

## -----------------------------------------------------------------------------
res_ots <- otSweep(
  dat            = dat,
  Yvar           = "Y",
  Xvars          = c("X1", "X2", "X3"),
  sweep_range    = 6:9,
  thrX           = c(X1 = 7, X2 = 7, X3 = 7),
  dir.exp        = 1,
  return_details = TRUE
)

head(res_ots$summary)

## -----------------------------------------------------------------------------
sweep_list_dts_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

sweep_range_dts_Y <- 6:8

res_dts <- dtSweep(
  dat            = dat,
  Yvar           = "Y",
  Xvars          = c("X1", "X2", "X3"),
  sweep_list_X   = sweep_list_dts_X,
  sweep_range_Y  = sweep_range_dts_Y,
  dir.exp        = 1,
  return_details = TRUE
)

head(res_dts$summary)

## ----eval=FALSE---------------------------------------------------------------
# # Returns only the first solution (M1)
# # Backward compatible with v0.1.x
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7),
#   extract_mode = "first"  # Default
# )

## ----eval=FALSE---------------------------------------------------------------
# # Returns all solutions concatenated
# # Useful for seeing all equivalent solutions
# result_all <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7),
#   extract_mode = "all"
# )
# 
# # Output includes n_solutions column
# head(result_all$summary)
# # expression column shows: "M1: A*B + C; M2: A*B + D; M3: ..."

## ----eval=FALSE---------------------------------------------------------------
# # Returns core conditions common to all solutions
# # Best for identifying robust findings
# result_core <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7),
#   extract_mode = "core"
# )
# 
# # Output includes:
# # - expression: core conditions
# # - peripheral_terms: conditions in some but not all solutions
# # - unique_terms: solution-specific conditions
# # - n_solutions: number of equivalent solutions

## ----eval=FALSE---------------------------------------------------------------
# # Generate full report
# generate_report(res_ots, "my_analysis_full.md", format = "full")

## ----eval=FALSE---------------------------------------------------------------
# # Generate simple report
# generate_report(res_ots, "my_analysis_simple.md", format = "simple")

## ----eval=FALSE---------------------------------------------------------------
# # Complete workflow
# result <- otSweep(
#   dat = mydata,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )
# 
# # For main text
# generate_report(result, "manuscript_results.md", format = "simple")
# 
# # For supplementary materials
# generate_report(result, "supplementary_full.md", format = "full")

## ----eval=FALSE---------------------------------------------------------------
# # View stored parameters
# result$params
# 
# # Includes:
# # - Yvar, Xvars: variable names
# # - thrX, thrY: threshold values
# # - incl.cut, n.cut, pri.cut: QCA parameters
# # - dir.exp, include: minimization settings

## ----eval=FALSE---------------------------------------------------------------
# # Test with a single threshold first
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 7,  # Single value
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )

## ----eval=FALSE---------------------------------------------------------------
# # Expand to a small range
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:7,  # Small range
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )

## ----eval=FALSE---------------------------------------------------------------
# # Run full analysis only after confirming it works
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 5:9,  # Full range
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )

## ----eval=FALSE---------------------------------------------------------------
# # Manageable: 2 × 2 × 2 = 8 combinations
# sweep_list <- list(X1 = 6:7, X2 = 6:7, X3 = 6:7)
# 
# # Caution: 5 × 5 × 5 = 125 combinations
# sweep_list <- list(X1 = 5:9, X2 = 5:9, X3 = 5:9)
# 
# # Avoid: 5 × 5 × 5 × 5 × 5 = 3125 combinations!
# sweep_list <- list(X1 = 5:9, X2 = 5:9, X3 = 5:9, X4 = 5:9, X5 = 5:9)

## -----------------------------------------------------------------------------
sessionInfo()

