# TSQCA

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17899391.svg)](https://doi.org/10.5281/zenodo.17899391)

TSQCA is an R package implementing **Threshold-Sweep QCA (TS-QCA)**,  
a framework for systematically varying the thresholds used to binarize  
the outcome and conditions in crisp-set QCA.

After calibration, QCA results may change depending on how thresholds are set.  
TS-QCA evaluates this sensitivity by automatically:

- binarizing the data using many threshold candidates  
- generating truth tables  
- applying `QCA::minimize()`  
- extracting the solution, consistency, and coverage  

Implemented sweep types:

- **CTS-QCA (ctSweepS)**: Sweep the threshold of one condition  
- **MCTS-QCA (ctSweepM)**: Sweep thresholds of multiple conditions  
- **OTS-QCA (otSweep)**: Sweep the threshold of outcome only  
- **DTS-QCA (dtSweep)**: Sweep condition and outcome thresholds simultaneously (2D sweep)

> **Scope:** Version 0.4.1 focuses on **sufficiency analysis**. Necessity analysis is planned for future versions.

---

## Features (v0.4.1)

### Multiple Solution Detection (v0.2.0+)

QCA minimization can produce multiple equivalent intermediate solutions. TSQCA detects and reports these cases, allowing researchers to identify robust core conditions versus solution-specific peripheral conditions.

Use the `extract_mode` parameter to control output:

| Mode | Description | Use Case |
|------|-------------|----------|
| `"first"` | Returns only the first solution (M1) | Default, backward compatible |
| `"all"` | Returns all solutions concatenated | See all equivalent solutions |
| `"core"` | Returns core conditions common to all solutions | Identify robust findings |

### S3 Methods (v0.4.0+)

All sweep functions return objects with S3 class support:

- `print()`: Displays analysis overview with solution statistics
- `summary()`: Shows full results table with parameters

```r
result <- otSweep(...)
print(result)    # Quick overview
summary(result)  # Full details
```

### QCA-Compatible Arguments (v0.3.0+)

Arguments renamed to follow QCA package conventions:

| Old Name | New Name | Description |
|----------|----------|-------------|
| `Yvar` | `outcome` | Outcome variable name |
| `Xvars` | `conditions` | Condition variable names |

Old argument names still work with deprecation warnings.

### Negated Outcome Support (v0.3.0+)

Analyze conditions sufficient for the **absence** of the outcome:

```r
# Analyze when Y is LOW (below threshold)
result <- otSweep(
  dat = mydata,
  outcome = "~Y",  # Tilde prefix for negation
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX = c(X1 = 7, X2 = 7, X3 = 7)
)
```

### Automatic Report Generation (v0.2.0+)

Generate comprehensive markdown reports:

```r
result <- otSweep(
  dat = mydata,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX = c(X1 = 7, X2 = 7, X3 = 7)
)

# Full report with all details
generate_report(result, "my_analysis.md", format = "full")

# Simple report for journal manuscripts
generate_report(result, "my_analysis_simple.md", format = "simple")
```

Reports include:
- Analysis settings (for reproducibility)
- Solution formulas with core/peripheral conditions
- Fit measures (consistency, coverage, PRI)
- Cross-threshold comparison tables

---

## Installation

```r
install.packages("devtools")
devtools::install_github("im-research-yt/TSQCA")
```

## Relationship with QCA Package

TSQCA is built on top of the [QCA package](https://cran.r-project.org/package=QCA) (Duşa, 2019). All function arguments follow QCA conventions:

- **`incl.cut`, `n.cut`, `pri.cut`** → See `QCA::truthTable()`
  - Consistency, frequency, and PRI cutoffs for truth table construction
- **`include`, `dir.exp`** → See `QCA::minimize()`
  - Inclusion rule and directional expectations for logical minimization

### Why This Matters

- **Familiar Workflow**: If you know QCA, you already know TSQCA's parameters
- **Detailed Documentation**: For in-depth parameter explanations, refer to QCA package documentation
- **Seamless Integration**: TSQCA extends QCA without replacing it

### Quick Reference

```r
# Check QCA parameter documentation
?QCA::truthTable  # For incl.cut, n.cut, pri.cut
?QCA::minimize    # For include, dir.exp

# TSQCA uses these same parameters
result <- dtSweep(
  dat = sample_data,
  outcome = "Y",
  conditions = c("X1", "X2"),
  sweep_list_X = list(X1 = 6:7, X2 = 6:7),
  sweep_range_Y = 6:7,
  incl.cut = 0.8,   # QCA parameter
  n.cut = 1,        # QCA parameter
  pri.cut = 0       # QCA parameter
)
```

## Basic Setup

```r
library(QCA)
library(TSQCA)

dat <- read.csv("sample_data.csv", fileEncoding = "UTF-8")

outcome    <- "Y"
conditions <- c("X1", "X2", "X3")

str(dat)
```

## Working with Mixed Data Types

### Handling Binary Variables (0/1)

When your dataset contains **both continuous and binary (0/1) variables**, special attention is needed:

- **Do NOT use threshold sweep for binary variables** — they are already binarized
- **Specify threshold = 1** for binary variables to preserve their original values
- **Explicitly define thresholds** for each variable in `sweep_list`

#### Why Threshold = 1 for Binary Variables?

The `qca_bin()` function uses `x >= thr` for binarization:
- If `x = 0`: `0 >= 1` → FALSE → **0** (preserved)
- If `x = 1`: `1 >= 1` → TRUE → **1** (preserved)

#### Example: Mixed Data

```r
# Suppose X1 is binary (0/1), while X2 and X3 are continuous (0-10)
sweep_list <- list(
  X1 = 1,      # Binary variable: use threshold 1 to preserve values
  X2 = 6:8,    # Continuous: sweep thresholds
  X3 = 6:8     # Continuous: sweep thresholds
)

res_mcts <- ctSweepM(
  dat = dat,
  outcome = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_list = sweep_list,
  thrY = 7
)
```

This explores 1 × 3 × 3 = 9 threshold combinations, treating X1 as a fixed binary condition.

#### Common Mistake

```r
# WRONG: Using sweep range for binary variables
sweep_list <- list(
  X1 = 6:8,    # All values become 0 (since 0 < 6 and 1 < 6)
  X2 = 6:8,
  X3 = 6:8
)
```

**Best Practice**: Always specify thresholds explicitly for each variable based on its data type.

## Usage Examples

### 1. CTS-QCA: Single-Condition Sweep (ctSweepS)

```r
sweep_var <- "X3"      # Condition whose threshold will be varied
sweep_range <- 6:9     # Candidate threshold values

thrY <- 7              # Fixed threshold for outcome
thrX_default <- 7      # Fixed thresholds for other conditions

res_cts <- ctSweepS(
  dat          = dat,
  outcome      = "Y",
  conditions   = c("X1", "X2", "X3"),
  sweep_var    = sweep_var,
  sweep_range  = sweep_range,
  thrY         = thrY,
  thrX_default = thrX_default
)

print(res_cts)
```

### 2. MCTS-QCA: Multi-Condition Sweep (ctSweepM)

```r
# Threshold candidates for each condition
sweep_list <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

res_mcts <- ctSweepM(
  dat        = dat,
  outcome    = "Y",
  conditions = c("X1", "X2", "X3"),
  sweep_list = sweep_list,
  thrY       = 7
)

print(res_mcts)
```

### 3. OTS-QCA: Outcome Sweep (otSweep)

```r
thrX <- c(X1 = 7, X2 = 7, X3 = 7)  # Fixed thresholds for conditions
sweep_range_Y <- 6:9               # Candidate thresholds for outcome

res_ots <- otSweep(
  dat         = dat,
  outcome     = "Y",
  conditions  = c("X1", "X2", "X3"),
  sweep_range = sweep_range_Y,
  thrX        = thrX
)

print(res_ots)

# Generate report for detailed analysis
generate_report(res_ots, "ots_report.md", format = "full")
```

### 4. DTS-QCA: 2D Sweep (dtSweep)

```r
# Condition threshold candidates
sweep_list_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

# Outcome threshold candidates
sweep_range_Y <- 6:8

res_dts <- dtSweep(
  dat           = dat,
  outcome       = "Y",
  conditions    = c("X1", "X2", "X3"),
  sweep_list_X  = sweep_list_X,
  sweep_range_Y = sweep_range_Y
)

print(res_dts)
```

### 5. Using extract_mode

```r
# Show all equivalent solutions
result_all <- otSweep(
  dat         = dat,
  outcome     = "Y",
  conditions  = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX        = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "all"
)

# Extract only core conditions (common to all solutions)
result_core <- otSweep(
  dat         = dat,
  outcome     = "Y",
  conditions  = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX        = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "core"
)
```

## References

### Core QCA Methodology

- Ragin, C. C. (2008). *Redesigning Social Inquiry: Fuzzy Sets and Beyond*. University of Chicago Press. [DOI: 10.7208/chicago/9780226702797.001.0001](https://doi.org/10.7208/chicago/9780226702797.001.0001)
- Schneider, C. Q., & Wagemann, C. (2012). *Set-Theoretic Methods for the Social Sciences: A Guide to Qualitative Comparative Analysis*. Cambridge University Press. [DOI: 10.1017/CBO9781139004244](https://doi.org/10.1017/CBO9781139004244)

### QCA R Package

- Duşa, A. (2019). *QCA with R: A Comprehensive Resource*. Springer. [DOI: 10.1007/978-3-319-75668-4](https://doi.org/10.1007/978-3-319-75668-4)
- Duşa, A. (2018). Consistency Cubes: A Fast, Efficient Method for Exact Boolean Minimization. *The R Journal*, 10(2), 357–370. [DOI: 10.32614/RJ-2018-080](https://doi.org/10.32614/RJ-2018-080)
- Duşa, A. (2024). *QCA: Qualitative Comparative Analysis*. R package version 3.22. https://CRAN.R-project.org/package=QCA

### Robustness and Threshold Sensitivity

- Oana, I.-E., & Schneider, C. Q. (2024). A Robustness Test Protocol for Applied QCA: Theory and R Software Application. *Sociological Methods & Research*, 53(1), 57–88. [DOI: 10.1177/00491241211036158](https://doi.org/10.1177/00491241211036158)
- Oana, I.-E., & Schneider, C. Q. (2018). SetMethods: An Add-on R Package for Advanced QCA. *The R Journal*, 10(1), 507–533. [DOI: 10.32614/RJ-2018-031](https://doi.org/10.32614/RJ-2018-031)
- Skaaning, S.-E. (2011). Assessing the Robustness of Crisp-Set and Fuzzy-Set QCA Results. *Sociological Methods & Research*, 40(2), 391–408. [DOI: 10.1177/0049124111404818](https://doi.org/10.1177/0049124111404818)
- Thiem, A., Spöhel, R., & Duşa, A. (2016). Enhancing Sensitivity Diagnostics for Qualitative Comparative Analysis: A Combinatorial Approach. *Political Analysis*, 24(1), 104–120. [DOI: 10.1093/pan/mpv028](https://doi.org/10.1093/pan/mpv028)

## Acknowledgements

This package implements methods developed in research supported by JSPS KAKENHI Grant Number JP20K01998.

## License

MIT License.
