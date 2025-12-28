# =========================================================
## OTSQCA Analysis Script (v2 - with enhanced report)
## =========================================================
## This script demonstrates the enhanced generate_report()
## with Descriptive Statistics, Truth Table, Necessity Analysis,
## and Cross-Threshold Comparison
## =========================================================

library(TSQCA)

## =========================================================
## 1. データ読み込み
## =========================================================

dat <- read.csv("qcadata.csv", stringsAsFactors = FALSE,
                fileEncoding = "utf-8", row.names = 1)

cat("Data loaded: n =", nrow(dat), "\n")

## =========================================================
## 2. 分析設定
## =========================================================

Yvar  <- "Y"
Xvars <- c("KSP", "KPR", "PRD", "RVT", "RCM")

CPX <- 7
thrX <- setNames(rep(CPX, length(Xvars)), Xvars)

sweep_range <- 5:9
incl_cut <- 0.75

cat("Settings:\n")
cat("  Xvars:", paste(Xvars, collapse = ", "), "\n")
cat("  CPX:", CPX, "\n")
cat("  Y sweep:", min(sweep_range), "-", max(sweep_range), "\n")
cat("  incl.cut:", incl_cut, "\n")

## =========================================================
## 3. OTS-QCA 実行
## =========================================================

cat("\nRunning OTS-QCA...\n")

result <- otSweep(
  dat         = dat,
  Yvar        = Yvar,
  Xvars       = Xvars,
  sweep_range = sweep_range,
  thrX        = thrX,
  incl.cut    = incl_cut,
  return_details = TRUE
)

cat("Done.\n\n")
print(result$summary)

## =========================================================
## 4. レポート生成（FULL版）
## =========================================================

cat("\nGenerating FULL report...\n")

generate_report(
  result      = result,
  output_file = "otsqca_report_FULL_v2.md",
  format      = "full",
  title       = "OTS-QCA Analysis Report (FULL)",
  dat         = dat,                              # 元データ（記述統計用）
  desc_vars   = c(Yvar, Xvars)                   # 記述統計を出す変数
)

cat("Report saved: otsqca_report_FULL_v2.md\n")

## =========================================================
## 5. レポート生成（SIMPLE版）
## =========================================================

cat("\nGenerating SIMPLE report...\n")

generate_report(
  result      = result,
  output_file = "otsqca_report_SIMPLE_v2.md",
  format      = "simple",
  title       = "OTS-QCA Analysis Report (SIMPLE)"
)

cat("Report saved: otsqca_report_SIMPLE_v2.md\n")

## =========================================================
## 完了
## =========================================================

cat("\n")
cat("===========================================\n")
cat("Analysis completed!\n")
cat("===========================================\n")
cat("Output files:\n")
cat("  - otsqca_report_FULL_v2.md   (論文用・全情報)\n")
cat("  - otsqca_report_SIMPLE_v2.md (簡易版)\n")
cat("===========================================\n")
