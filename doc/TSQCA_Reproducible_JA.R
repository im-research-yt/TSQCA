## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(TSQCA)
library(QCA)

## -----------------------------------------------------------------------------
# データファイル名は適宜変更
library(TSQCA)
data("sample_data")
dat <- sample_data

# アウトカムと条件名
Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

# 確認
str(dat)
summary(dat)

## -----------------------------------------------------------------------------
# ベースラインとして用いる閾値
thrY_base  <- 7
thrX_base  <- 7

# X ごとの固定閾値（必要に応じて変更）
thrX_vec <- c(
  X1 = thrX_base,
  X2 = thrX_base,
  X3 = thrX_base
)
thrX_vec

## ----error=TRUE---------------------------------------------------------------
try({
sweep_var   <- "X3"   # 閾値を変化させる対象の条件（X）
sweep_range <- 6:9    # 試す閾値候補
thrY         <- 7     # Y の閾値（固定）
thrX_default <- 7     # その他 X の閾値（固定）

res_cts <- ctSweepS(
  dat            = dat,
  Yvar           = "Y",
  Xvars          = c("X1", "X2", "X3"),
  sweep_var      = "X3",
  sweep_range    = 6:9,
  thrY           = 7,
  thrX_default   = 7,
  dir.exp        = 1,
  return_details = TRUE
)

head(res_cts$summary)
})

## ----eval=FALSE---------------------------------------------------------------
# write.csv(res_cts$summary, file = "TSQCA_CTS_results.csv", row.names = FALSE)

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

## ----eval=FALSE---------------------------------------------------------------
# write.csv(res_mcts$summary, file = "TSQCA_MCTS_results.csv", row.names = FALSE)

## -----------------------------------------------------------------------------
sweep_range_ots <- 6:9

res_ots <- otSweep(
  dat            = dat,
  Yvar           = "Y",
  Xvars          = c("X1", "X2", "X3"),
  sweep_range    = sweep_range_ots,
  thrX           = thrX_vec,
  dir.exp        = 1,
  return_details = TRUE
)

res_ots$summary

## ----eval=FALSE---------------------------------------------------------------
# write.csv(res_ots$summary, file = "TSQCA_OTS_results.csv", row.names = FALSE)

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
# write.csv(res_dts$summary, file = "TSQCA_DTS_results.csv", row.names = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# res_all <- otSweep(
#   dat            = dat,
#   Yvar           = "Y",
#   Xvars          = c("X1", "X2", "X3"),
#   sweep_range    = 6:9,
#   thrX           = thrX_vec,
#   dir.exp        = 1,
#   extract_mode   = "all",
#   return_details = TRUE
# )
# 
# # n_solutions カラムを含む結果を確認
# head(res_all$summary)

## ----eval=FALSE---------------------------------------------------------------
# res_core <- otSweep(
#   dat            = dat,
#   Yvar           = "Y",
#   Xvars          = c("X1", "X2", "X3"),
#   sweep_range    = 6:9,
#   thrX           = thrX_vec,
#   dir.exp        = 1,
#   extract_mode   = "core",
#   return_details = TRUE
# )
# 
# # コア条件、周辺条件、ユニーク項を含む結果を確認
# head(res_core$summary)

## ----eval=FALSE---------------------------------------------------------------
# generate_report(res_ots, "TSQCA_OTS_report_full.md", format = "full")

## ----eval=FALSE---------------------------------------------------------------
# generate_report(res_ots, "TSQCA_OTS_report_simple.md", format = "simple")

## ----eval=FALSE---------------------------------------------------------------
# # 保存されたパラメータを確認
# res_ots$params
# 
# # 出力例:
# # $Yvar
# # [1] "Y"
# # $Xvars
# # [1] "X1" "X2" "X3"
# # $thrX
# # X1 X2 X3
# #  7  7  7
# # $incl.cut
# # [1] 0.8
# # $n.cut
# # [1] 1
# # $pri.cut
# # [1] 0

## -----------------------------------------------------------------------------
sessionInfo()

