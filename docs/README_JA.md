# TSQCA（日本語版）

[English README](https://im-research-yt.github.io/TSQCA/README.md)

TSQCA は、Qualitative Comparative Analysis（QCA）に対して  
**閾値スイープ型の分析（TS-QCA）**を実行する R パッケージです。

キャリブレーション後の crisp-set QCA では、  
アウトカム Y と条件 X の閾値設定が結果に大きく影響します。

TS-QCA は、多数の閾値候補を体系的に試しながら以下を自動実行します。

- データの二値化  
- Truth Table の生成  
- [`QCA::minimize()`](https://rdrr.io/pkg/QCA/man/minimize.html)
  による最小化  
- 解の式・整合性・被覆値の抽出

実装されている手法：

- **CTS–QCA（ctSweepS）**：1つの X の閾値を変化  
- **MCTS–QCA（ctSweepM）**：複数の X の閾値を同時に変化  
- **OTS–QCA（otSweep）**：Y の閾値だけを変化  
- **DTS–QCA（dtSweep）**：X と Y の閾値を同時に変化（2次元スイープ）

## インストール

``` r
install.packages("devtools")
devtools::install_github("your-account/TSQCA")
```

## 基本設定

``` r
library(QCA)
library(TSQCA)

dat <- read.csv("sample_data.csv", fileEncoding = "UTF-8")

Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

str(dat)
```

# 1. CTS–QCA：単一条件 X スイープ（ctSweepS）

``` r
sweep_var <- "X3"      # 閾値を変化させる対象の条件（X）
sweep_range <- 6:9     # 試す閾値候補

thrY <- 7              # Y の閾値（固定）
thrX_default <- 7      # その他 X の閾値（固定）

res_cts <- ctSweepS(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_var      = sweep_var,      # スイープ対象の X
  sweep_range    = sweep_range,    # スイープする閾値
  thrY           = thrY,           # Y の閾値
  thrX_default   = thrX_default,   # その他 X の閾値
  return_details = FALSE
)

head(res_cts)
```

# 2. MCTS–QCA：複数条件 X スイープ（ctSweepM）

``` r
# X の各条件に対する閾値候補の指定
sweep_list <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

res_mcts <- ctSweepM(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list     = sweep_list,     # 各 X の閾値候補
  thrY           = 7,              # Y の閾値（固定）
  return_details = FALSE
)

head(res_mcts)
```

# 3. OTS–QCA：Y の閾値スイープ（otSweep）

``` r
thrX <- c(X1 = 7, X2 = 7, X3 = 7)  # X の閾値（固定）
sweep_range_Y <- 6:9               # Y の閾値候補

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = sweep_range_Y,  # Y の閾値候補
  thrX           = thrX,           # 固定する X の閾値
  return_details = FALSE
)

head(res_ots)
```

# 4. DTS–QCA：X×Y 二次元スイープ（dtSweep）

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

head(res_dts)
```

## サンプルデータ（rda 形式として同梱）

``` r
d <- read.csv("sample_data.csv", fileEncoding = "UTF-8")
save(d, file = "data/sample_data.rda")
```

## 参考文献

### QCA方法論の基礎

- Ragin, C. C. (2008). *Redesigning Social Inquiry: Fuzzy Sets and
  Beyond*. University of Chicago Press. [DOI:
  10.7208/chicago/9780226702797.001.0001](https://doi.org/10.7208/chicago/9780226702797.001.0001)
- Schneider, C. Q., & Wagemann, C. (2012). *Set-Theoretic Methods for
  the Social Sciences: A Guide to Qualitative Comparative Analysis*.
  Cambridge University Press. [DOI:
  10.1017/CBO9781139004244](https://doi.org/10.1017/CBO9781139004244)

### QCA R パッケージ

- Duşa, A. (2019). *QCA with R: A Comprehensive Resource*. Springer.
  [DOI:
  10.1007/978-3-319-75668-4](https://doi.org/10.1007/978-3-319-75668-4)
- Duşa, A. (2018). Consistency Cubes: A Fast, Efficient Method for Exact
  Boolean Minimization. *The R Journal*, 10(2), 357–370. [DOI:
  10.32614/RJ-2018-080](https://doi.org/10.32614/RJ-2018-080)

### ロバストネスと閾値感度分析

- Oana, I.-E., & Schneider, C. Q. (2024). A Robustness Test Protocol for
  Applied QCA: Theory and R Software Application. *Sociological Methods
  & Research*, 53(1), 57–88. [DOI:
  10.1177/00491241211036158](https://doi.org/10.1177/00491241211036158)
- Oana, I.-E., & Schneider, C. Q. (2018). SetMethods: An Add-on R
  Package for Advanced QCA. *The R Journal*, 10(1), 507–533. [DOI:
  10.32614/RJ-2018-031](https://doi.org/10.32614/RJ-2018-031)
- Skaaning, S.-E. (2011). Assessing the Robustness of Crisp-Set and
  Fuzzy-Set QCA Results. *Sociological Methods & Research*, 40(2),
  391–408. [DOI:
  10.1177/0049124111404818](https://doi.org/10.1177/0049124111404818)
- Thiem, A., Spöhel, R., & Duşa, A. (2016). Enhancing Sensitivity
  Diagnostics for Qualitative Comparative Analysis: A Combinatorial
  Approach. *Political Analysis*, 24(1), 104–120. [DOI:
  10.1093/pan/mpv028](https://doi.org/10.1093/pan/mpv028)

## ライセンス

MIT License.
