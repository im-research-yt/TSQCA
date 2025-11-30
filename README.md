# TSQCA

[Japanese README](README_JA.md)

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

- **CTS-QCA (ctSweepS)**: Sweep the threshold of one X  
- **MCTS-QCA (ctSweepM)**: Sweep thresholds of multiple X conditions  
- **OTS-QCA (otSweep)**: Sweep the threshold of Y only  
- **DTS-QCA (dtSweep)**: Sweep X and Y thresholds simultaneously (2D sweep)

---

## Installation

```r
install.packages("devtools")
devtools::install_github("your-account/TSQCA")
```

---

## Basic Setup

```r
library(QCA)
library(TSQCA)

dat <- read.csv("sample_data.csv", fileEncoding = "UTF-8")

Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

str(dat)
```

---

# 1. CTS-QCA: single-condition X sweep (ctSweepS)

```r
sweep_var <- "X3"      # Condition (X) whose threshold will be varied
sweep_range <- 6:9     # Candidate threshold values

thrY <- 7              # Fixed threshold for Y
thrX_default <- 7      # Fixed thresholds for other X's

res_cts <- ctSweepS(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_var      = sweep_var,      # X to sweep
  sweep_range    = sweep_range,    # Threshold candidates for X
  thrY           = thrY,           # Fixed Y threshold
  thrX_default   = thrX_default,   # Fixed thresholds for other X's
  return_details = FALSE
)

head(res_cts)
```

---

# 2. MCTS-QCA: multi-condition X sweep (ctSweepM)

```r
# Threshold candidates for each X
sweep_list <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

res_mcts <- ctSweepM(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list     = sweep_list,     # Threshold candidates for each X
  thrY           = 7,              # Fixed Y threshold
  return_details = FALSE
)

head(res_mcts)
```

---

# 3. OTS-QCA: outcome Y sweep (otSweep)

```r
thrX <- c(X1 = 7, X2 = 7, X3 = 7)  # Fixed thresholds for X
sweep_range_Y <- 6:9               # Candidate thresholds for Y

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = sweep_range_Y,  # Y threshold candidates
  thrX           = thrX,           # Fixed X thresholds
  return_details = FALSE
)

head(res_ots)
```

---

# 4. DTS-QCA: 2D sweep of X and Y (dtSweep)

```r
# X-side threshold candidates (multiple conditions)
sweep_list_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

# Y-side threshold candidates
sweep_range_Y <- 6:8

res_dts <- dtSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list_X   = sweep_list_X,   # X threshold candidates
  sweep_range_Y  = sweep_range_Y,  # Y threshold candidates
  return_details = FALSE
)

head(res_dts)
```

---

## Sample Data

```r
d <- read.csv("sample_data.csv", fileEncoding = "UTF-8")
save(d, file = "data/sample_data.rda")
```

---

## License

MIT License.
