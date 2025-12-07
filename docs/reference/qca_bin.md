# Binary calibration helper for TSQCA

Converts a numeric vector into a crisp set (0/1) based on a threshold.

## Usage

``` r
qca_bin(x, thr)
```

## Arguments

- x:

  Numeric vector.

- thr:

  Numeric scalar. Cases with `x >= thr` are coded as 1, others as 0.

## Value

Integer vector of 0/1 with the same length as `x`.
