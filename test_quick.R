## =========================================================
## TSQCA v0.5.1 Quick Verification Script
## =========================================================
## Minimal script to verify basic functionality
## =========================================================

library(TSQCA)
data("sample_data", package = "TSQCA")

cat("=== Quick Verification ===\n\n")

# 1. otSweep
cat("1. otSweep: ")
res_ots <- otSweep(
  dat = sample_data,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:8,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  return_details = TRUE
)
cat("OK (", nrow(res_ots$summary), " rows)\n", sep = "")

# 2. ctSweepS
cat("2. ctSweepS: ")
res_cts <- ctSweepS(
  dat = sample_data,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_var = "X3",
  sweep_range = 6:9,
  thrY = 7,
  thrX_default = 7,
  return_details = TRUE
)
cat("OK (", nrow(res_cts$summary), " rows)\n", sep = "")

# 3. ctSweepM
cat("3. ctSweepM: ")
res_mcts <- ctSweepM(
  dat = sample_data,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_list = list(X1 = 6:7, X2 = 6:7, X3 = 6:7),
  thrY = 7,
  return_details = TRUE
)
cat("OK (", nrow(res_mcts$summary), " rows)\n", sep = "")

# 4. dtSweep
cat("4. dtSweep: ")
res_dts <- dtSweep(
  dat = sample_data,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_list_X = list(X1 = 6:7, X2 = 6:7, X3 = 6:7),
  sweep_range_Y = 6:7,
  return_details = TRUE
)
cat("OK (", nrow(res_dts$summary), " rows)\n", sep = "")

# 5. generate_report
cat("5. generate_report: ")
report_file <- "test_ots_report.md"  # 作業ディレクトリに保存
generate_report(
  result = res_ots,
  output_file = report_file,
  dat = sample_data,
  format = "full"
)
cat("OK (", file.info(report_file)$size, " bytes)\n", sep = "")
cat("   -> Saved to: ", normalizePath(report_file), "\n", sep = "")

# 6. config_chart_from_paths
cat("6. config_chart_from_paths: ")
chart <- config_chart_from_paths(c("A*B*~C", "A*D"))
cat("OK\n")

cat("\n=== All checks passed! ===\n")
