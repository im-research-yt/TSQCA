# TSQCA（日本語版）

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17899391.svg)](https://doi.org/10.5281/zenodo.17899391)

[English README](README.md)

TSQCA は、Qualitative Comparative Analysis（QCA）に対して  
**閾値スイープ型の分析（TS-QCA）**を実行する R パッケージです。

キャリブレーション後の crisp-set QCA では、  
アウトカム Y と条件 X の閾値設定が結果に大きく影響します。

TS-QCA は、多数の閾値候補を体系的に試しながら以下を自動実行します。

- データの二値化  
- Truth Table の生成  
- `QCA::minimize()` による最小化  
- 解の式・整合性・被覆値の抽出

実装されている手法：

- **CTS–QCA（ctSweepS）**：1つの X の閾値を変化  
- **MCTS–QCA（ctSweepM）**：複数の X の閾値を同時に変化  
- **OTS–QCA（otSweep）**：Y の閾値だけを変化  
- **DTS–QCA（dtSweep）**：X と Y の閾値を同時に変化（2次元スイープ）

## インストール

```r
install.packages("devtools")
devtools::install_github("im-research-yt/TSQCA")
```

## QCAパッケージとの関係

TSQCAは[QCAパッケージ](https://cran.r-project.org/package=QCA)（Duşa, 2019）の上に構築されています。すべての関数引数はQCAの規約に従っています：

- **`incl.cut`, `n.cut`, `pri.cut`** → `QCA::truthTable()`を参照
  - Truth Table構築のための整合性、頻度、PRIのカットオフ値
- **`include`, `dir.exp`** → `QCA::minimize()`を参照
  - 論理最小化のための包含ルールと方向性期待値

### なぜこれが重要か

- **馴染みのあるワークフロー**：QCAを知っていれば、TSQCAのパラメータも既に理解しています
- **詳細なドキュメント**：パラメータの詳しい説明は、QCAパッケージのドキュメントを参照してください
- **シームレスな統合**：TSQCAはQCAを置き換えるのではなく、拡張します

### クイックリファレンス

```r
# QCAパラメータのドキュメントを確認
?QCA::truthTable  # incl.cut, n.cut, pri.cut について
?QCA::minimize    # include, dir.exp について

# TSQCAは同じパラメータを使用
result <- dtSweep(
  dat = sample_data,
  Yvar = "Y",
  Xvars = c("X1", "X2"),
  sweep_list_X = list(X1 = 6:7, X2 = 6:7),
  sweep_range_Y = 6:7,
  incl.cut = 0.8,   # QCAパラメータ
  n.cut = 2,        # QCAパラメータ
  pri.cut = 0.5     # QCAパラメータ
)
```

## 基本設定

```r
library(QCA)
library(TSQCA)

dat <- read.csv("sample_data.csv", fileEncoding = "UTF-8")

Yvar  <- "Y"
Xvars <- c("X1", "X2", "X3")

str(dat)
```

## 混合データタイプの扱い

### 2値変数（0/1）の取り扱い

データセットに**連続変数と2値変数（0/1）が混在している場合**、以下の点に注意が必要です：

- **2値変数に対して閾値スイープを行わない** — すでに2値化されているため
- **2値変数には閾値 1 を指定**して元の値を保持する
- **`sweep_list`で各変数の閾値を明示的に定義**する

#### なぜ2値変数には閾値1を指定するのか？

`qca_bin()`関数は `x >= thr` で2値化を行います：
- `x = 0` の場合: `0 >= 1` → FALSE → **0**（元の値を保持）
- `x = 1` の場合: `1 >= 1` → TRUE → **1**（元の値を保持）

#### 例：混合データの場合

```r
# X1が2値変数（0/1）、X2とX3が連続変数（0-10）の場合
sweep_list <- list(
  X1 = 1,      # 2値変数：閾値1で元の値を保持
  X2 = 6:8,    # 連続変数：閾値をスイープ
  X3 = 6:8     # 連続変数：閾値をスイープ
)

res_mcts <- ctSweepM(
  dat = dat,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_list = sweep_list,
  thrY = 7
)
```

これにより 1 × 3 × 3 = 9 通りの閾値組み合わせを探索し、X1は固定された2値条件として扱われます。

#### よくある間違い

```r
# 間違い：2値変数に対してスイープ範囲を指定
sweep_list <- list(
  X1 = 6:8,    # すべての値が0になる（0 < 6 かつ 1 < 6 のため）
  X2 = 6:8,
  X3 = 6:8
)
```

**推奨方法**：各変数のデータタイプに基づいて、常に閾値を明示的に指定してください。

# 1. CTS–QCA：単一条件 X スイープ（ctSweepS）

```r
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

```r
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

```r
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

```r
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

```r
d <- read.csv("sample_data.csv", fileEncoding = "UTF-8")
save(d, file = "data/sample_data.rda")
```

## 参考文献

### QCA方法論の基礎

- Ragin, C. C. (2008). *Redesigning Social Inquiry: Fuzzy Sets and Beyond*. University of Chicago Press. [DOI: 10.7208/chicago/9780226702797.001.0001](https://doi.org/10.7208/chicago/9780226702797.001.0001)
- Schneider, C. Q., & Wagemann, C. (2012). *Set-Theoretic Methods for the Social Sciences: A Guide to Qualitative Comparative Analysis*. Cambridge University Press. [DOI: 10.1017/CBO9781139004244](https://doi.org/10.1017/CBO9781139004244)

### QCA R パッケージ

- Duşa, A. (2019). *QCA with R: A Comprehensive Resource*. Springer. [DOI: 10.1007/978-3-319-75668-4](https://doi.org/10.1007/978-3-319-75668-4)
- Duşa, A. (2018). Consistency Cubes: A Fast, Efficient Method for Exact Boolean Minimization. *The R Journal*, 10(2), 357–370. [DOI: 10.32614/RJ-2018-080](https://doi.org/10.32614/RJ-2018-080)
- Duşa, A. (2024). *QCA: Qualitative Comparative Analysis*. R package version 3.22. https://CRAN.R-project.org/package=QCA

### ロバストネスと閾値感度分析

- Oana, I.-E., & Schneider, C. Q. (2024). A Robustness Test Protocol for Applied QCA: Theory and R Software Application. *Sociological Methods & Research*, 53(1), 57–88. [DOI: 10.1177/00491241211036158](https://doi.org/10.1177/00491241211036158)
- Oana, I.-E., & Schneider, C. Q. (2018). SetMethods: An Add-on R Package for Advanced QCA. *The R Journal*, 10(1), 507–533. [DOI: 10.32614/RJ-2018-031](https://doi.org/10.32614/RJ-2018-031)
- Skaaning, S.-E. (2011). Assessing the Robustness of Crisp-Set and Fuzzy-Set QCA Results. *Sociological Methods & Research*, 40(2), 391–408. [DOI: 10.1177/0049124111404818](https://doi.org/10.1177/0049124111404818)
- Thiem, A., Spöhel, R., & Duşa, A. (2016). Enhancing Sensitivity Diagnostics for Qualitative Comparative Analysis: A Combinatorial Approach. *Political Analysis*, 24(1), 104–120. [DOI: 10.1093/pan/mpv028](https://doi.org/10.1093/pan/mpv028)

## 謝辞

本パッケージは、JSPS科研費JP20K01998の助成を受けた研究で開発された手法を実装しています。

## ライセンス

MIT License.
