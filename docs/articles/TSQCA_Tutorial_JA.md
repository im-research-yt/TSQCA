# TSQCA Tutorial (Japanese)

## はじめに

TS-QCA（Threshold-Sweep QCA）は、crisp-set QCA において  
**アウトカム Y と条件 X
の閾値設定が結果に与える影響を体系的に評価する**  
ためのフレームワークです。

QCA はキャリブレーション後、設定した閾値に基づいて  
データを 0/1 の集合に分けます。  
しかし、閾値が少し変わるだけで、Truth Table
や最小化解が変化することがあります。

TS-QCA はその問題に対して、以下を自動実行します。

- 多数の閾値候補に基づくデータの二値化  
- Truth Table の生成  
- [`QCA::minimize()`](https://rdrr.io/pkg/QCA/man/minimize.html)
  による最小化  
- 解（式・整合性・被覆値）の抽出

------------------------------------------------------------------------

## 実装されている4手法

TSQCA パッケージでは、TS-QCA の4つのスイープ手法を実装しています。

| 手法         | 変化させる閾値 | 固定する閾値 | 目的                   |
|--------------|----------------|--------------|------------------------|
| **CTS–QCA**  | 1つの X        | Y + 他の X   | 個別条件の影響を見る   |
| **MCTS–QCA** | 複数の X       | Y            | 複数条件の組合せの影響 |
| **OTS–QCA**  | Y              | 全ての X     | アウトカム閾値の影響   |
| **DTS–QCA**  | X と Y         | なし         | 全面的感度分析         |

------------------------------------------------------------------------

## データ準備

TS-QCA は、キャリブレーション済みデータ（例：0〜10
スケール）を想定しています。  
閾値は数値（整数・実数）であれば構いません。

``` r
# Adjust the file name as needed
library(TSQCA)
data("sample_data")
dat <- sample_data
str(dat)
#> 'data.frame':    80 obs. of  4 variables:
#>  $ Y : int  8 4 5 7 2 2 7 5 3 8 ...
#>  $ X1: int  7 2 6 8 8 9 8 8 1 5 ...
#>  $ X2: int  7 5 8 4 0 5 8 4 4 2 ...
#>  $ X3: int  1 6 6 5 3 4 5 3 6 8 ...

Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")
```

※
欠損値（NA）が含まれている場合、スイープ実行前に除去または補完を行ってください。

------------------------------------------------------------------------

## CTS–QCA（ctSweepS）：単一条件 X スイープ

CTS–QCA は、**1つの X 条件の閾値だけを変化させ**、  
Y とその他の X の閾値は固定したまま、結果の変化を確認する手法です。

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
#> Warning: package 'QCA' was built under R version 4.4.3
#> Loading required package: admisc
#> Warning: package 'admisc' was built under R version 4.4.3
#> 
#> To cite package QCA in publications, please use:
#>   Dusa, Adrian (2019) QCA with R. A Comprehensive Resource.
#>   Springer International Publishing.
#> 
#> To run the graphical user interface, use: runGUI()
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

------------------------------------------------------------------------

## MCTS–QCA（ctSweepM）：複数条件 X スイープ

MCTS–QCA は、**複数の X 条件の閾値を同時に変化させ**、  
すべての組合せに対して QCA を実行する手法です。

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

------------------------------------------------------------------------

## OTS–QCA（otSweep）：アウトカム Y のスイープ

OTS–QCA は、**アウトカム Y の閾値だけを変化させる**手法です。  
条件 X の閾値は固定したまま、Y
の閾値の取り方が結果に与える影響を評価します。

``` r
thrX <- c(X1 = 7, X2 = 7, X3 = 7)  # X の閾値（固定）

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = 6:9,            # Y の閾値候補
  thrX           = thrX,
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

head(res_ots)
#>   thrY  expression   inclS      covS
#> 1    6  X3 + X1*X2 0.90625 0.8529412
#> 2    7  X3 + X1*X2 0.90625 0.8787879
#> 3    8 No solution      NA        NA
#> 4    9 No solution      NA        NA
```

------------------------------------------------------------------------

## DTS–QCA（dtSweep）：X×Y 二次元スイープ

DTS–QCA は、**X の閾値（複数条件）と Y の閾値を同時に変化させる**  
最も包括的なスイープ手法です。

``` r
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

head(res_dts)
#>   combo_id thrY             thrX  expression     inclS      covS
#> 1        1    6 X1=6, X2=6, X3=6       X1*X2 0.8333333 0.4411765
#> 2        1    7 X1=6, X2=6, X3=6       X1*X2 0.8333333 0.4545455
#> 3        1    8 X1=6, X2=6, X3=6 No solution        NA        NA
#> 4        2    6 X1=7, X2=6, X3=6       X1*X2 1.0000000 0.3823529
#> 5        2    7 X1=7, X2=6, X3=6       X1*X2 1.0000000 0.3939394
#> 6        2    8 X1=7, X2=6, X3=6 No solution        NA        NA
```

------------------------------------------------------------------------

## 出力の読み方

各スイープ関数の出力には、概ね次の情報が含まれます。

- どの閾値を用いたか（X または Y の閾値）
- その閾値のもとで得られた最小化解（`expression`）
- 解の整合性（`inclS`）
- 解の被覆値（`covS`）

一般的な解釈の目安：

- **整合性（inclS）がおおよそ 0.8
  以上**であれば、十分条件として望ましいとされることが多いです。  
- **被覆値（covS）**は、その解がどの程度のケースを説明できているか（実質的な影響力）を示します。

※ 閾値をわずかに変えただけで最小化解が大きく変化する場合、  
その結果は閾値設定に敏感であり、ロバスト性に課題があると判断できます。

------------------------------------------------------------------------

## まとめ

TSQCA を用いることで、QCA における閾値設定の影響を体系的に評価し、  
分析結果のロバスト性を確認できます。

CTS / MCTS / OTS / DTS の各手法により、研究者は：

- 頑健な因果パターンの特定  
- 閾値に敏感な結果の検出  
- 分析全体の信頼性向上

を実現できます。

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

## セッション情報

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
