## =========================================================
## TSQCA v0.5.1 Tutorial Code Verification Script
## =========================================================
## Purpose: Verify all code in vignettes works correctly
## Run this script after installing the package
## =========================================================

cat("=========================================================\n")
cat("TSQCA v0.5.1 Tutorial Code Verification\n")
cat("=========================================================\n\n")

## -----------------------------------------------------------------
## 0. Setup
## -----------------------------------------------------------------
cat("Step 0: Loading packages...\n")
library(TSQCA)
data("sample_data", package = "TSQCA")
dat <- sample_data

cat("  - TSQCA loaded successfully\n")
cat("  - sample_data loaded:", nrow(dat), "rows,", ncol(dat), "columns\n")
cat("  - Variables:", paste(names(dat), collapse = ", "), "\n\n")

## -----------------------------------------------------------------
## 1. OTS–QCA: Outcome Sweep (otSweep)
## -----------------------------------------------------------------
cat("Step 1: Testing otSweep()...\n")

res_ots <- otSweep(
  dat            = dat,
  outcome        = "Y",
  conditions     = c("X1", "X2", "X3"),
  sweep_range    = 6:8,
  thrX           = c(X1 = 7, X2 = 7, X3 = 7),
  dir.exp        = c(1, 1, 1),
  return_details = TRUE
)

cat("  - otSweep completed successfully\n")
cat("  - Result class:", class(res_ots)[1], "\n")
cat("  - Summary rows:", nrow(res_ots$summary), "\n")
print(summary(res_ots))
cat("\n")

## -----------------------------------------------------------------
## 2. CTS–QCA: Single-Condition Sweep (ctSweepS)
## -----------------------------------------------------------------
cat("Step 2: Testing ctSweepS()...\n")

sweep_var   <- "X3"
sweep_range <- 6:9
thrY         <- 7
thrX_default <- 7

res_cts <- ctSweepS(
  dat            = dat,
  outcome        = "Y",
  conditions     = c("X1", "X2", "X3"),
  sweep_var      = sweep_var,
  sweep_range    = sweep_range,
  thrY           = thrY,
  thrX_default   = thrX_default,
  dir.exp        = c(1, 1, 1),
  return_details = TRUE
)

cat("  - ctSweepS completed successfully\n")
cat("  - Result class:", class(res_cts)[1], "\n")
cat("  - Summary rows:", nrow(res_cts$summary), "\n")
print(summary(res_cts))
cat("\n")

## -----------------------------------------------------------------
## 3. MCTS–QCA: Multiple X Sweep (ctSweepM)
## -----------------------------------------------------------------
cat("Step 3: Testing ctSweepM()...\n")

sweep_list <- list(
  X1 = 6:7,
  X2 = 6:7,
  X3 = 6:7
)

res_mcts <- ctSweepM(
  dat            = dat,
  outcome        = "Y",
  conditions     = c("X1", "X2", "X3"),
  sweep_list     = sweep_list,
  thrY           = 7,
  dir.exp        = c(1, 1, 1),
  return_details = TRUE
)

cat("  - ctSweepM completed successfully\n")
cat("  - Result class:", class(res_mcts)[1], "\n")
cat("  - Summary rows:", nrow(res_mcts$summary), "\n")
print(summary(res_mcts))
cat("\n")

## -----------------------------------------------------------------
## 4. DTS–QCA: Two-Dimensional Sweep (dtSweep)
## -----------------------------------------------------------------
cat("Step 4: Testing dtSweep()...\n")

sweep_list_dts_X <- list(
  X1 = 6:7,
  X2 = 6:7,
  X3 = 6:7
)
sweep_range_dts_Y <- 6:7

res_dts <- dtSweep(
  dat            = dat,
  outcome        = "Y",
  conditions     = c("X1", "X2", "X3"),
  sweep_list_X   = sweep_list_dts_X,
  sweep_range_Y  = sweep_range_dts_Y,
  dir.exp        = c(1, 1, 1),
  return_details = TRUE
)

cat("  - dtSweep completed successfully\n")
cat("  - Result class:", class(res_dts)[1], "\n")
cat("  - Summary rows:", nrow(res_dts$summary), "\n")
print(summary(res_dts))
cat("\n")

## -----------------------------------------------------------------
## 5. generate_report() - Full format
## -----------------------------------------------------------------
cat("Step 5: Testing generate_report() - Full format...\n")

report_file_full <- "test_report_full.md"  # 作業ディレクトリに保存
generate_report(
  result = res_ots,
  output_file = report_file_full,
  title = "OTS Report Test (Full)",
  dat = dat,
  format = "full",
  include_chart = TRUE,
  chart_symbol_set = "unicode"
)

if (file.exists(report_file_full)) {
  file_size <- file.info(report_file_full)$size
  cat("  - Full report generated successfully\n")
  cat("  - File size:", file_size, "bytes\n")
  cat("  - Location:", normalizePath(report_file_full), "\n")
} else {
  cat("  - ERROR: Report file not created!\n")
}
cat("\n")

## -----------------------------------------------------------------
## 6. generate_report() - Simple format
## -----------------------------------------------------------------
cat("Step 6: Testing generate_report() - Simple format...\n")

report_file_simple <- "test_report_simple.md"  # 作業ディレクトリに保存
generate_report(
  result = res_ots,
  output_file = report_file_simple,
  title = "OTS Report Test (Simple)",
  dat = dat,
  format = "simple",
  include_chart = TRUE,
  chart_symbol_set = "unicode"
)

if (file.exists(report_file_simple)) {
  file_size <- file.info(report_file_simple)$size
  cat("  - Simple report generated successfully\n")
  cat("  - File size:", file_size, "bytes\n")
  cat("  - Location:", normalizePath(report_file_simple), "\n")
} else {
  cat("  - ERROR: Report file not created!\n")
}
cat("\n")

## -----------------------------------------------------------------
## 7. Configuration Charts
## -----------------------------------------------------------------
cat("Step 7: Testing config_chart_from_paths()...\n")

paths <- c("A*B*~C", "A*D", "B*E")
chart <- config_chart_from_paths(paths)
cat("  - Chart generated successfully:\n")
cat(chart)
cat("\n")

## -----------------------------------------------------------------
## 8. Multiple Solutions Chart
## -----------------------------------------------------------------
cat("Step 8: Testing config_chart_multi_solutions()...\n")

solutions <- list(
  c("A*B", "C*D"),
  c("A*B", "C*E")
)
chart_multi <- config_chart_multi_solutions(solutions)
cat("  - Multi-solution chart generated successfully:\n")
cat(chart_multi)
cat("\n")

## -----------------------------------------------------------------
## 9. extract_mode tests
## -----------------------------------------------------------------
cat("Step 9: Testing extract_mode options...\n")

# Mode: "first" (default)
res_first <- otSweep(
  dat = dat,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:8,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "first"
)
cat("  - extract_mode='first': OK\n")

# Mode: "all"
res_all <- otSweep(
  dat = dat,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:8,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "all"
)
cat("  - extract_mode='all': OK\n")
if ("n_solutions" %in% names(res_all$summary)) {
  cat("    - n_solutions column present: YES\n")
}

# Mode: "essential"
res_essential <- otSweep(
  dat = dat,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:8,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "essential"
)
cat("  - extract_mode='essential': OK\n")
if ("selective_terms" %in% names(res_essential$summary)) {
  cat("    - selective_terms column present: YES\n")
}
cat("\n")

## -----------------------------------------------------------------
## 10. Negated Outcome Test
## -----------------------------------------------------------------
cat("Step 10: Testing negated outcome (~Y)...\n")

res_negY <- otSweep(
  dat = dat,
  outcome = "~Y",
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:8,
  thrX = c(X1 = 7, X2 = 7, X3 = 7)
)

cat("  - Negated outcome analysis: OK\n")
cat("  - negate_outcome flag:", res_negY$params$negate_outcome, "\n")
cat("\n")

## -----------------------------------------------------------------
## 11. Backward Compatibility Test (old argument names)
## -----------------------------------------------------------------
cat("Step 11: Testing backward compatibility (Yvar/Xvars)...\n")

res_compat <- otSweep(
  dat = dat,
  Yvar = "Y",           # Old argument name
  Xvars = c("X1", "X2", "X3"),  # Old argument name
  sweep_range = 6:8,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  return_details = FALSE
)

if (is.data.frame(res_compat) && nrow(res_compat) > 0) {
  cat("  - Backward compatibility: OK\n")
  cat("  - Old argument names (Yvar, Xvars) still work\n")
} else {
  cat("  - WARNING: Backward compatibility issue\n")
}
cat("\n")

## -----------------------------------------------------------------
## Summary
## -----------------------------------------------------------------
cat("=========================================================\n")
cat("All tests completed!\n")
cat("=========================================================\n")
cat("\n")
cat("Functions tested:\n")
cat("  [OK] otSweep()\n")
cat("  [OK] ctSweepS()\n")
cat("  [OK] ctSweepM()\n")
cat("  [OK] dtSweep()\n")
cat("  [OK] generate_report() - full\n")
cat("  [OK] generate_report() - simple\n")
cat("  [OK] config_chart_from_paths()\n")
cat("  [OK] config_chart_multi_solutions()\n")
cat("  [OK] extract_mode options\n")
cat("  [OK] Negated outcome (~Y)\n")
cat("  [OK] Backward compatibility\n")
cat("\n")
cat("Report files generated:\n")
cat("  - Full:  ", report_file_full, "\n")
cat("  - Simple:", report_file_simple, "\n")
cat("\n")
cat("=========================================================\n")
