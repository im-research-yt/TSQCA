## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# Adjust the file name as needed
library(TSQCA)
data("sample_data")
dat <- sample_data
str(dat)

Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

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
thrX <- c(X1 = 7, X2 = 7, X3 = 7)  # X の閾値（固定）

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = 6:9,            # Y の閾値候補
  thrX           = thrX,
  return_details = FALSE
)

head(res_ots)

## -----------------------------------------------------------------------------
# X 側の閾値候補（複数条件）
sweep_list_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

# Y 側の閾値候補
sweep_range_Y <- 6:8

res_dts <- dtSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list_X   = sweep_list_X,   # X 側の閾値候補
  sweep_range_Y  = sweep_range_Y,  # Y 側の閾値候補
  return_details = FALSE
)

head(res_dts)

## -----------------------------------------------------------------------------
sessionInfo()

