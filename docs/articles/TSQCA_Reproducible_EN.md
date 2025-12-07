# TSQCA Reproducible Code (English)

This document provides **reproducible code** for TSQCA analyses.  
It is designed to be inserted directly into a research article’s
appendix  
or provided as supplementary analysis documentation. All code is fully
executable and ordered for reproducibility.

------------------------------------------------------------------------

## 1. Load Packages

``` r
library(TSQCA)
library(QCA)
#> Warning: package 'QCA' was built under R version 4.4.3
#> Loading required package: admisc
#> Warning: package 'admisc' was built under R version 4.4.3
#> 
#> To cite package QCA in publications, please use:
#>   Dusa, Adrian (2019) QCA with R. A Comprehensive Resource.
#>   Springer International Publishing.
#> 
#> To run the graphical user interface, use: runGUI()
```

------------------------------------------------------------------------

## 2. Load Data

``` r
# Adjust the file name as needed
library(TSQCA)
data("sample_data")
dat <- sample_data

# Outcome and conditions
Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

# Quick inspection
str(dat)
#> 'data.frame':    80 obs. of  4 variables:
#>  $ Y : int  8 4 5 7 2 2 7 5 3 8 ...
#>  $ X1: int  7 2 6 8 8 9 8 8 1 5 ...
#>  $ X2: int  7 5 8 4 0 5 8 4 4 2 ...
#>  $ X3: int  1 6 6 5 3 4 5 3 6 8 ...
summary(dat)
#>        Y                X1               X2              X3        
#>  Min.   : 0.000   Min.   : 0.000   Min.   : 0.00   Min.   : 0.000  
#>  1st Qu.: 3.000   1st Qu.: 3.000   1st Qu.: 3.00   1st Qu.: 3.000  
#>  Median : 5.000   Median : 5.500   Median : 5.00   Median : 5.000  
#>  Mean   : 5.513   Mean   : 5.237   Mean   : 5.05   Mean   : 4.925  
#>  3rd Qu.: 7.250   3rd Qu.: 8.000   3rd Qu.: 7.25   3rd Qu.: 7.000  
#>  Max.   :10.000   Max.   :10.000   Max.   :10.00   Max.   :10.000
```

------------------------------------------------------------------------

## 3. Baseline Thresholds

``` r
thrY_base <- 7
thrX_base <- 7

# Fixed X thresholds (for OTS–QCA)
thrX_vec <- c(
  X1 = thrX_base,
  X2 = thrX_base,
  X3 = thrX_base
)
thrX_vec
#> X1 X2 X3 
#>  7  7  7
```

------------------------------------------------------------------------

## 4. CTS–QCA (ctSweepS)

Sweep a **single condition X** (example: X3).

``` r
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
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().

head(res_cts)
#>   threshold expression   inclS      covS
#> 1         6      X1*X2 1.00000 0.3030303
#> 2         7 X3 + X1*X2 0.90625 0.8787879
#> 3         8 X3 + X1*X2 1.00000 0.8181818
#> 4         9 X3 + X1*X2 1.00000 0.5151515
```

Export:

``` r
write.csv(res_cts, file = "TSQCA_CTS_results.csv", row.names = FALSE)
```

------------------------------------------------------------------------

## 5. MCTS–QCA (ctSweepM)

Sweep **multiple X thresholds simultaneously**.

``` r
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
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().

head(res_mcts)
#>   combo_id        threshold expression     inclS      covS
#> 1        1 X1=6, X2=6, X3=6      X1*X2 0.8333333 0.4545455
#> 2        2 X1=7, X2=6, X3=6      X1*X2 1.0000000 0.3939394
#> 3        3 X1=8, X2=6, X3=6      X1*X2 1.0000000 0.3030303
#> 4        4 X1=6, X2=7, X3=6  X1*X2*~X3 0.8181818 0.2727273
#> 5        5 X1=7, X2=7, X3=6      X1*X2 1.0000000 0.3030303
#> 6        6 X1=8, X2=7, X3=6      X1*X2 1.0000000 0.2121212
```

Export:

``` r
write.csv(res_mcts, file = "TSQCA_MCTS_results.csv", row.names = FALSE)
```

------------------------------------------------------------------------

## 6. OTS–QCA (otSweep)

Sweep **only the outcome threshold (Y)**.

``` r
sweep_range_ots <- 6:9

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = sweep_range_ots,
  thrX           = thrX_vec,
  return_details = FALSE
)
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().

res_ots
#>   thrY  expression   inclS      covS
#> 1    6  X3 + X1*X2 0.90625 0.8529412
#> 2    7  X3 + X1*X2 0.90625 0.8787879
#> 3    8 No solution      NA        NA
#> 4    9 No solution      NA        NA
```

Export:

``` r
write.csv(res_ots, file = "TSQCA_OTS_results.csv", row.names = FALSE)
```

------------------------------------------------------------------------

## 7. DTS–QCA (dtSweep)

Two-dimensional sweep: **X thresholds × Y thresholds**.

``` r
sweep_list_dts_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)
sweep_range_dts_Y <- 6:8

res_dts <- dtSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list_X   = sweep_list_dts_X,
  sweep_range_Y  = sweep_range_dts_Y,
  return_details = FALSE
)
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = inputt, mv = mv, collapse = collapse): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(impmat = expressions, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(primes, mv = mv, collapse = collapse, curly = curly): Function writePrimeimp() is deprecated, use writePIs().
#> Warning in admisc::writePrimeimp(configs, mv = mv, collapse = collapse, : Function writePrimeimp() is deprecated, use writePIs().

res_dts
#>    combo_id thrY             thrX     expression     inclS      covS
#> 1         1    6 X1=6, X2=6, X3=6          X1*X2 0.8333333 0.4411765
#> 2         1    7 X1=6, X2=6, X3=6          X1*X2 0.8333333 0.4545455
#> 3         1    8 X1=6, X2=6, X3=6    No solution        NA        NA
#> 4         2    6 X1=7, X2=6, X3=6          X1*X2 1.0000000 0.3823529
#> 5         2    7 X1=7, X2=6, X3=6          X1*X2 1.0000000 0.3939394
#> 6         2    8 X1=7, X2=6, X3=6    No solution        NA        NA
#> 7         3    6 X1=8, X2=6, X3=6          X1*X2 1.0000000 0.2941176
#> 8         3    7 X1=8, X2=6, X3=6          X1*X2 1.0000000 0.3030303
#> 9         3    8 X1=8, X2=6, X3=6    No solution        NA        NA
#> 10        4    6 X1=6, X2=7, X3=6      X1*X2*~X3 0.8181818 0.2647059
#> 11        4    7 X1=6, X2=7, X3=6      X1*X2*~X3 0.8181818 0.2727273
#> 12        4    8 X1=6, X2=7, X3=6    No solution        NA        NA
#> 13        5    6 X1=7, X2=7, X3=6          X1*X2 1.0000000 0.2941176
#> 14        5    7 X1=7, X2=7, X3=6          X1*X2 1.0000000 0.3030303
#> 15        5    8 X1=7, X2=7, X3=6    No solution        NA        NA
#> 16        6    6 X1=8, X2=7, X3=6          X1*X2 1.0000000 0.2058824
#> 17        6    7 X1=8, X2=7, X3=6          X1*X2 1.0000000 0.2121212
#> 18        6    8 X1=8, X2=7, X3=6    No solution        NA        NA
#> 19        7    6 X1=6, X2=8, X3=6    No solution        NA        NA
#> 20        7    7 X1=6, X2=8, X3=6    No solution        NA        NA
#> 21        7    8 X1=6, X2=8, X3=6    No solution        NA        NA
#> 22        8    6 X1=7, X2=8, X3=6          X1*X2 1.0000000 0.2352941
#> 23        8    7 X1=7, X2=8, X3=6          X1*X2 1.0000000 0.2424242
#> 24        8    8 X1=7, X2=8, X3=6    No solution        NA        NA
#> 25        9    6 X1=8, X2=8, X3=6          X1*X2 1.0000000 0.1764706
#> 26        9    7 X1=8, X2=8, X3=6          X1*X2 1.0000000 0.1818182
#> 27        9    8 X1=8, X2=8, X3=6    No solution        NA        NA
#> 28       10    6 X1=6, X2=6, X3=7             X3 0.8636364 0.5588235
#> 29       10    7 X1=6, X2=6, X3=7             X3 0.8636364 0.5757576
#> 30       10    8 X1=6, X2=6, X3=7      X1*~X2*X3 0.8000000 0.2000000
#> 31       11    6 X1=7, X2=6, X3=7 ~X1*X3 + X1*X2 0.9310345 0.7941176
#> 32       11    7 X1=7, X2=6, X3=7 ~X1*X3 + X1*X2 0.9310345 0.8181818
#> 33       11    8 X1=7, X2=6, X3=7    No solution        NA        NA
#> 34       12    6 X1=8, X2=6, X3=7 ~X1*X3 + X1*X2 0.9259259 0.7352941
#> 35       12    7 X1=8, X2=6, X3=7 ~X1*X3 + X1*X2 0.9259259 0.7575758
#> 36       12    8 X1=8, X2=6, X3=7    No solution        NA        NA
#> 37       13    6 X1=6, X2=7, X3=7             X3 0.8636364 0.5588235
#> 38       13    7 X1=6, X2=7, X3=7             X3 0.8636364 0.5757576
#> 39       13    8 X1=6, X2=7, X3=7    No solution        NA        NA
#> 40       14    6 X1=7, X2=7, X3=7     X3 + X1*X2 0.9062500 0.8529412
#> 41       14    7 X1=7, X2=7, X3=7     X3 + X1*X2 0.9062500 0.8787879
#> 42       14    8 X1=7, X2=7, X3=7    No solution        NA        NA
#> 43       15    6 X1=8, X2=7, X3=7     X3 + X1*X2 0.8965517 0.7647059
#> 44       15    7 X1=8, X2=7, X3=7     X3 + X1*X2 0.8965517 0.7878788
#> 45       15    8 X1=8, X2=7, X3=7    No solution        NA        NA
#> 46       16    6 X1=6, X2=8, X3=7             X3 0.8636364 0.5588235
#> 47       16    7 X1=6, X2=8, X3=7             X3 0.8636364 0.5757576
#> 48       16    8 X1=6, X2=8, X3=7    No solution        NA        NA
#> 49       17    6 X1=7, X2=8, X3=7     X3 + X1*X2 0.9000000 0.7941176
#> 50       17    7 X1=7, X2=8, X3=7     X3 + X1*X2 0.9000000 0.8181818
#> 51       17    8 X1=7, X2=8, X3=7    No solution        NA        NA
#> 52       18    6 X1=8, X2=8, X3=7     X3 + X1*X2 0.8928571 0.7352941
#> 53       18    7 X1=8, X2=8, X3=7     X3 + X1*X2 0.8928571 0.7575758
#> 54       18    8 X1=8, X2=8, X3=7    No solution        NA        NA
#> 55       19    6 X1=6, X2=6, X3=8     X3 + X1*X2 0.9090909 0.8823529
#> 56       19    7 X1=6, X2=6, X3=8     X3 + X1*X2 0.9090909 0.9090909
#> 57       19    8 X1=6, X2=6, X3=8      X1*~X2*X3 1.0000000 0.2000000
#> 58       20    6 X1=7, X2=6, X3=8     X3 + X1*X2 1.0000000 0.8235294
#> 59       20    7 X1=7, X2=6, X3=8     X3 + X1*X2 1.0000000 0.8484848
#> 60       20    8 X1=7, X2=6, X3=8      X1*~X2*X3 1.0000000 0.1500000
#> 61       21    6 X1=8, X2=6, X3=8     X3 + X1*X2 1.0000000 0.7352941
#> 62       21    7 X1=8, X2=6, X3=8     X3 + X1*X2 1.0000000 0.7575758
#> 63       21    8 X1=8, X2=6, X3=8      X1*~X2*X3 1.0000000 0.1000000
#> 64       22    6 X1=6, X2=7, X3=8             X3 1.0000000 0.5000000
#> 65       22    7 X1=6, X2=7, X3=8             X3 1.0000000 0.5151515
#> 66       22    8 X1=6, X2=7, X3=8          X1*X3 0.8333333 0.2500000
#> 67       23    6 X1=7, X2=7, X3=8     X3 + X1*X2 1.0000000 0.7941176
#> 68       23    7 X1=7, X2=7, X3=8     X3 + X1*X2 1.0000000 0.8181818
#> 69       23    8 X1=7, X2=7, X3=8          X1*X3 0.8000000 0.2000000
#> 70       24    6 X1=8, X2=7, X3=8     X3 + X1*X2 1.0000000 0.7058824
#> 71       24    7 X1=8, X2=7, X3=8     X3 + X1*X2 1.0000000 0.7272727
#> 72       24    8 X1=8, X2=7, X3=8     ~X1*~X2*X3 0.8000000 0.4000000
#> 73       25    6 X1=6, X2=8, X3=8             X3 1.0000000 0.5000000
#> 74       25    7 X1=6, X2=8, X3=8             X3 1.0000000 0.5151515
#> 75       25    8 X1=6, X2=8, X3=8          X1*X3 0.8333333 0.2500000
#> 76       26    6 X1=7, X2=8, X3=8     X3 + X1*X2 1.0000000 0.7352941
#> 77       26    7 X1=7, X2=8, X3=8     X3 + X1*X2 1.0000000 0.7575758
#> 78       26    8 X1=7, X2=8, X3=8          X1*X3 0.8000000 0.2000000
#> 79       27    6 X1=8, X2=8, X3=8     X3 + X1*X2 1.0000000 0.6764706
#> 80       27    7 X1=8, X2=8, X3=8     X3 + X1*X2 1.0000000 0.6969697
#> 81       27    8 X1=8, X2=8, X3=8    No solution        NA        NA
```

Export:

``` r
write.csv(res_dts, file = "TSQCA_DTS_results.csv", row.names = FALSE)
```

### References

For more information on TS-QCA methodology, see:

- Ragin, C. C. (2008). *Redesigning Social Inquiry: Fuzzy Sets and
  Beyond*. University of Chicago Press. DOI:
  [10.7208/chicago/9780226702797.001.0001](https://doi.org/10.7208/chicago/9780226702797.001.0001)
- Duşa, A. (2019). *QCA with R: A Comprehensive Resource*. Springer.
  DOI:
  [10.1007/978-3-319-75668-4](https://doi.org/10.1007/978-3-319-75668-4)
- Oana, I.-E., & Schneider, C. Q. (2024). A Robustness Test Protocol for
  Applied QCA: Theory and R Software Application. *Sociological Methods
  & Research*, 53(1), 57–88. DOI:
  [10.1177/00491241211036158](https://doi.org/10.1177/00491241211036158)

## 8. Session Information

``` r
sessionInfo()
#> R version 4.4.1 (2024-06-14 ucrt)
#> Platform: x86_64-w64-mingw32/x64
#> Running under: Windows 11 x64 (build 26200)
#> 
#> Matrix products: default
#> 
#> 
#> locale:
#> [1] LC_COLLATE=Japanese_Japan.utf8  LC_CTYPE=Japanese_Japan.utf8   
#> [3] LC_MONETARY=Japanese_Japan.utf8 LC_NUMERIC=C                   
#> [5] LC_TIME=Japanese_Japan.utf8    
#> 
#> time zone: Asia/Tokyo
#> tzcode source: internal
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] QCA_3.23    admisc_0.38 TSQCA_0.1.0
#> 
#> loaded via a namespace (and not attached):
#>  [1] cli_3.6.5         knitr_1.50        rlang_1.1.6       xfun_0.52        
#>  [5] promises_1.3.3    textshaping_1.0.1 shiny_1.11.1      xtable_1.8-4     
#>  [9] jsonlite_2.0.0    htmltools_0.5.8.1 httpuv_1.6.16     ragg_1.4.0       
#> [13] sass_0.4.10       lpSolve_5.6.23    rmarkdown_2.29    evaluate_1.0.4   
#> [17] jquerylib_0.1.4   fastmap_1.2.0     yaml_2.3.10       lifecycle_1.0.4  
#> [21] compiler_4.4.1    fs_1.6.6          htmlwidgets_1.6.4 Rcpp_1.1.0       
#> [25] later_1.4.2       rstudioapi_0.17.1 systemfonts_1.2.3 digest_0.6.37    
#> [29] R6_2.6.1          magrittr_2.0.3    bslib_0.9.0       declared_0.25    
#> [33] tools_4.4.1       mime_0.13         venn_1.12         pkgdown_2.2.0    
#> [37] cachem_1.1.0      desc_1.4.3
```
