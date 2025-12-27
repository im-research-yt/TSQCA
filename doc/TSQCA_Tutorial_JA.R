## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(TSQCA)
data("sample_data")
dat <- sample_data
str(dat)

Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

## ----eval=FALSE---------------------------------------------------------------
# # 正しい方法：各変数の閾値を明示的に指定
# sweep_list <- list(
#   X1 = 1,      # 2値変数: 閾値1を使用
#   X2 = 6:8,    # 連続変数: 閾値をスイープ
#   X3 = 6:8     # 連続変数: 閾値をスイープ
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
# # 間違い：2値変数に対してスイープ範囲を指定
# sweep_list <- list(
#   X1 = 6:8,    # すべての値が0になる（0 < 6 かつ 1 < 6 のため）
#   X2 = 6:8,
#   X3 = 6:8
# )

## ----eval=FALSE---------------------------------------------------------------
# # 変数の範囲を確認
# summary(dat[, c("X1", "X2", "X3")])
# 
# # 2値変数を識別（0と1のみ）
# sapply(dat[, c("X1", "X2", "X3")], function(x) {
#   unique_vals <- sort(unique(x))
#   if (length(unique_vals) == 2 && all(unique_vals == c(0, 1))) {
#     "2値変数（閾値 = 1 を使用）"
#   } else {
#     paste("連続変数（範囲:", min(x), "-", max(x), ")")
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
# # 最初の解（M1）のみを返す
# # v0.1.xと後方互換
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7),
#   extract_mode = "first"  # デフォルト
# )

## ----eval=FALSE---------------------------------------------------------------
# # 全ての解を連結して返す
# # 全ての等価解を確認したい場合に有用
# result_all <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7),
#   extract_mode = "all"
# )
# 
# # 出力には n_solutions カラムが含まれる
# head(result_all$summary)
# # expression カラムは: "M1: A*B + C; M2: A*B + D; M3: ..." のように表示

## ----eval=FALSE---------------------------------------------------------------
# # 全ての解に共通するコア条件を返す
# # 頑健な知見を特定するのに最適
# result_core <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7),
#   extract_mode = "core"
# )
# 
# # 出力に含まれる内容:
# # - expression: コア条件
# # - peripheral_terms: 一部の解に含まれる条件
# # - unique_terms: 解固有の条件
# # - n_solutions: 等価解の数

## ----eval=FALSE---------------------------------------------------------------
# # FULLレポートを生成
# generate_report(res_ots, "my_analysis_full.md", format = "full")

## ----eval=FALSE---------------------------------------------------------------
# # SIMPLEレポートを生成
# generate_report(res_ots, "my_analysis_simple.md", format = "simple")

## ----eval=FALSE---------------------------------------------------------------
# # 完全なワークフロー
# result <- otSweep(
#   dat = mydata,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:9,
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )
# 
# # 本文用
# generate_report(result, "manuscript_results.md", format = "simple")
# 
# # 補足資料用
# generate_report(result, "supplementary_full.md", format = "full")

## ----eval=FALSE---------------------------------------------------------------
# # 保存されたパラメータを確認
# result$params
# 
# # 含まれる内容:
# # - Yvar, Xvars: 変数名
# # - thrX, thrY: 閾値
# # - incl.cut, n.cut, pri.cut: QCAパラメータ
# # - dir.exp, include: 最小化設定

## ----eval=FALSE---------------------------------------------------------------
# # まず単一の閾値でテスト
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 7,  # 単一値
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )

## ----eval=FALSE---------------------------------------------------------------
# # 小さな範囲に拡大
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 6:7,  # 小範囲
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )

## ----eval=FALSE---------------------------------------------------------------
# # 動作確認後、完全な分析を実行
# result <- otSweep(
#   dat = dat,
#   Yvar = "Y",
#   Xvars = c("X1", "X2", "X3"),
#   sweep_range = 5:9,  # 全範囲
#   thrX = c(X1 = 7, X2 = 7, X3 = 7)
# )

## ----eval=FALSE---------------------------------------------------------------
# # 管理可能: 2 × 2 × 2 = 8 組み合わせ
# sweep_list <- list(X1 = 6:7, X2 = 6:7, X3 = 6:7)
# 
# # 注意: 5 × 5 × 5 = 125 組み合わせ
# sweep_list <- list(X1 = 5:9, X2 = 5:9, X3 = 5:9)
# 
# # 避ける: 5 × 5 × 5 × 5 × 5 = 3125 組み合わせ!
# sweep_list <- list(X1 = 5:9, X2 = 5:9, X3 = 5:9, X4 = 5:9, X5 = 5:9)

## -----------------------------------------------------------------------------
sessionInfo()

