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
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_list = sweep_list,
#   thrY = 7
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
sweep_var   <- "X3"   # 閾値を変化させる対象の条件（X）
sweep_range <- 6:9    # 試す閾値候補

thrY         <- 7     # Y の閾値（固定）
thrX_default <- 7     # その他 X の閾値（固定）

res_cts <- ctSweepS(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_var      = sweep_var,
  sweep_range    = sweep_range,
  thrY           = thrY,
  thrX_default   = thrX_default,
  return_details = FALSE
)

head(res_cts)
})

## ----error=TRUE---------------------------------------------------------------
try({
sweep_list <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

res_mcts <- ctSweepM(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list     = sweep_list,
  thrY           = 7,
  return_details = FALSE
)

head(res_mcts)
})

## -----------------------------------------------------------------------------
thrX <- c(X1 = 7, X2 = 7, X3 = 7)

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = 6:9,
  thrX           = thrX,
  return_details = FALSE
)

head(res_ots)

## -----------------------------------------------------------------------------
sweep_list_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

sweep_range_Y <- 6:8

res_dts <- dtSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list_X   = sweep_list_X,
  sweep_range_Y  = sweep_range_Y,
  return_details = FALSE
)

head(res_dts)

## -----------------------------------------------------------------------------
sessionInfo()

