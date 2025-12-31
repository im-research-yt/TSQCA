# TSQCA

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17899391.svg)](https://doi.org/10.5281/zenodo.17899391)

TSQCAは、**閾値スイープQCA（Threshold-Sweep QCA: TS-QCA）**を実装したRパッケージです。  
クリスプ集合QCAにおいて、アウトカムと条件の二値化に使用する閾値を体系的に変化させるフレームワークを提供します。

キャリブレーション後、QCAの結果は閾値の設定方法によって変化する可能性があります。  
TS-QCAは以下を自動的に実行することで、この感度を評価します：

- 多数の閾値候補を使用してデータを二値化  
- 真理表を生成  
- `QCA::minimize()` を適用  
- 解、一貫性、カバレッジを抽出  

実装されているスイープタイプ：

- **CTS-QCA (ctSweepS)**: 単一の条件Xの閾値をスイープ  
- **MCTS-QCA (ctSweepM)**: 複数の条件Xの閾値をスイープ  
- **OTS-QCA (otSweep)**: アウトカムYの閾値のみをスイープ  
- **DTS-QCA (dtSweep)**: XとYの閾値を同時にスイープ（2Dスイープ）

> **対象範囲:** バージョン0.2.0は**十分条件分析**に焦点を当てています。必要条件分析は将来のバージョンで予定しています。

---

## v0.2.0の新機能

### 複数解の検出

QCAの最小化は複数の等価な中間解を生成することがあります。TSQCAはこれらのケースを検出・報告し、研究者が頑健な必須主項と解固有の選択的主項を識別できるようにします。

`extract_mode` パラメータで出力を制御：

| モード | 説明 | ユースケース |
|--------|------|--------------|
| `"first"` | 最初の解（M1）のみを返す | デフォルト、後方互換 |
| `"all"` | すべての解を連結して返す | すべての等価解を確認 |
| `"essential"` | すべての解に共通する必須主項を返す | 頑健な発見を特定 |

```r
# すべての解を検出・表示
result <- otSweep(
  dat = mydata,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "all"  # すべての解を表示
)

# 必須主項のみを抽出
result_essential <- otSweep(
  dat = mydata,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX = c(X1 = 7, X2 = 7, X3 = 7),
  extract_mode = "essential"  # 必須主項を表示
)
```

### 自動レポート生成

新しい `generate_report()` 関数で包括的なMarkdownレポートを作成：

```r
# return_details = TRUE（現在のデフォルト）で分析を実行
result <- otSweep(
  dat = mydata,
  Yvar = "Y",
  Xvars = c("X1", "X2", "X3"),
  sweep_range = 6:9,
  thrX = c(X1 = 7, X2 = 7, X3 = 7)
)

# 完全版レポートを生成
generate_report(result, "my_analysis.md", format = "full")

# シンプル版レポートを生成（学術論文用）
generate_report(result, "my_analysis_simple.md", format = "simple")
```

レポートに含まれる内容：
- 分析設定（再現性のため）
- 必須/選択的主項を含む解の式
- 適合度指標（一貫性、カバレッジ、PRI）
- 閾値間比較表

### デフォルト値の更新

QCAパッケージの慣例に合わせて：
- `n.cut` のデフォルトを 2 から **1** に変更
- `pri.cut` のデフォルトを 0.5 から **0** に変更

---

## v0.5.0の新機能 (2025-12-31)

### レポートへの構成チャート自動統合

構成チャートがレポートに自動的に含まれるようになりました。`generate_report()` を使用：

```r
# レポートに構成チャートが自動的に含まれます（デフォルト）
generate_report(result, "my_report.md", format = "full")

# 構成チャートを無効にする場合
generate_report(result, "my_report.md", include_chart = FALSE)

# 学術論文用にLaTeXシンボルを使用
generate_report(result, "my_report.md", chart_symbol_set = "latex")
```

### 単体の構成チャート関数

Fissスタイルの構成チャート（Table 5形式）を直接生成：

```r
# パス文字列から
paths <- c("A*B*~C", "A*D")
chart <- config_chart_from_paths(paths)
cat(chart)
```

出力：
```
| 条件 | C1 | C2 |
|:--:|:--:|:--:|
| A | ● | ● |
| B | ● |   |
| C | ⊗ |   |
| D |   | ● |
```

3種類のシンボルセットが利用可能：`"unicode"` (● / ⊗)、`"ascii"` (O / X)、`"latex"` ($\bullet$ / $\otimes$)

### 用語に関する注意

TSQCAは正確なブール代数の用語を使用しています：

| 用語 | 意味 |
|------|------|
| **必須主項（Essential Prime Implicants: EPI）** | すべての等価解（M1, M2...）に含まれる項 |
| **選択的主項（Selective Prime Implicants: SPI）** | 一部の解にのみ含まれる項 |

> **注意**: これはFiss (2011) の「コア条件」とは異なる概念です。コア条件は簡略解と中間解を比較して定義されます。詳細は `docs/TSQCA_Terminology_Guide_JA.md` を参照してください。

---

## インストール

```r
install.packages("devtools")
devtools::install_github("im-research-yt/TSQCA")
```

## QCAパッケージとの関係

TSQCAは[QCAパッケージ](https://cran.r-project.org/package=QCA)（Duşa, 2019）の上に構築されています。すべての関数引数はQCAの慣例に従います：

- **`incl.cut`, `n.cut`, `pri.cut`** → `QCA::truthTable()` を参照
  - 真理表構築のための一貫性、頻度、PRIカットオフ
- **`include`, `dir.exp`** → `QCA::minimize()` を参照
  - 論理最小化のための包含ルールと方向性期待

### なぜこれが重要か

- **使い慣れたワークフロー**: QCAを知っていれば、TSQCAのパラメータも既に知っています
- **詳細なドキュメント**: パラメータの詳細な説明はQCAパッケージのドキュメントを参照
- **シームレスな統合**: TSQCAはQCAを置き換えるのではなく拡張します

### クイックリファレンス

```r
# QCAパラメータのドキュメントを確認
?QCA::truthTable  # incl.cut, n.cut, pri.cut用
?QCA::minimize    # include, dir.exp用

# TSQCAは同じパラメータを使用
result <- dtSweep(
  dat = sample_data,
  Yvar = "Y",
  Xvars = c("X1", "X2"),
  sweep_list_X = list(X1 = 6:7, X2 = 6:7),
  sweep_range_Y = 6:7,
  incl.cut = 0.8,   # QCAパラメータ
  n.cut = 1,        # QCAパラメータ（v0.2.0でのデフォルト）
  pri.cut = 0       # QCAパラメータ（v0.2.0でのデフォルト）
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

### バイナリ変数（0/1）の扱い

データセットに**連続変数とバイナリ（0/1）変数の両方**が含まれる場合、特別な注意が必要です：

- バイナリ変数には**閾値スイープを使用しない** — 既に二値化されています
- バイナリ変数には**閾値 = 1を指定**して元の値を保持
- `sweep_list` で各変数の閾値を**明示的に定義**

#### なぜバイナリ変数に閾値 = 1 なのか？

`qca_bin()` 関数は二値化に `x >= thr` を使用します：
- `x = 0` の場合: `0 >= 1` → FALSE → **0**（保持）
- `x = 1` の場合: `1 >= 1` → TRUE → **1**（保持）

#### 例：混合データ

```r
# X1がバイナリ（0/1）、X2とX3が連続変数（0-10）の場合
sweep_list <- list(
  X1 = 1,      # バイナリ変数：値を保持するため閾値1を使用
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

これは 1 × 3 × 3 = 9 の閾値組み合わせを探索し、X1を固定バイナリ条件として扱います。

#### よくある間違い

```r
# 間違い：バイナリ変数にスイープ範囲を使用
sweep_list <- list(
  X1 = 6:8,    # すべての値が0になる（0 < 6 かつ 1 < 6 のため）
  X2 = 6:8,
  X3 = 6:8
)
```

**ベストプラクティス**: データタイプに基づいて、各変数の閾値を常に明示的に指定してください。

# 1. CTS-QCA: 単一条件Xスイープ (ctSweepS)

```r
sweep_var <- "X3"      # 閾値を変化させる条件（X）
sweep_range <- 6:9     # 閾値候補

thrY <- 7              # Yの固定閾値
thrX_default <- 7      # 他のXの固定閾値

res_cts <- ctSweepS(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_var      = sweep_var,      # スイープするX
  sweep_range    = sweep_range,    # Xの閾値候補
  thrY           = thrY,           # Yの固定閾値
  thrX_default   = thrX_default,   # 他のXの固定閾値
  return_details = TRUE            # v0.2.0でのデフォルト
)

head(res_cts$summary)
```

# 2. MCTS-QCA: 複数条件Xスイープ (ctSweepM)

```r
# 各Xの閾値候補
sweep_list <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

res_mcts <- ctSweepM(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list     = sweep_list,     # 各Xの閾値候補
  thrY           = 7,              # Yの固定閾値
  return_details = TRUE            # v0.2.0でのデフォルト
)

head(res_mcts$summary)
```

# 3. OTS-QCA: アウトカムYスイープ (otSweep)

```r
thrX <- c(X1 = 7, X2 = 7, X3 = 7)  # Xの固定閾値
sweep_range_Y <- 6:9               # Yの閾値候補

res_ots <- otSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_range    = sweep_range_Y,  # Yの閾値候補
  thrX           = thrX,           # Xの固定閾値
  return_details = TRUE            # v0.2.0でのデフォルト
)

head(res_ots$summary)

# 詳細分析用のレポートを生成
generate_report(res_ots, "ots_report.md", format = "full")
```

# 4. DTS-QCA: XとYの2Dスイープ (dtSweep)

```r
# X側の閾値候補（複数条件）
sweep_list_X <- list(
  X1 = 6:8,
  X2 = 6:8,
  X3 = 6:8
)

# Y側の閾値候補
sweep_range_Y <- 6:8

res_dts <- dtSweep(
  dat            = dat,
  Yvar           = Yvar,
  Xvars          = Xvars,
  sweep_list_X   = sweep_list_X,   # Xの閾値候補
  sweep_range_Y  = sweep_range_Y,  # Yの閾値候補
  return_details = TRUE            # v0.2.0でのデフォルト
)

head(res_dts$summary)
```

## サンプルデータ

```r
d <- read.csv("sample_data.csv", fileEncoding = "UTF-8")
save(d, file = "data/sample_data.rda")
```

## 参考文献

### QCA方法論の中核

- Ragin, C. C. (2008). *Redesigning Social Inquiry: Fuzzy Sets and Beyond*. University of Chicago Press. [DOI: 10.7208/chicago/9780226702797.001.0001](https://doi.org/10.7208/chicago/9780226702797.001.0001)
- Schneider, C. Q., & Wagemann, C. (2012). *Set-Theoretic Methods for the Social Sciences: A Guide to Qualitative Comparative Analysis*. Cambridge University Press. [DOI: 10.1017/CBO9781139004244](https://doi.org/10.1017/CBO9781139004244)

### QCA Rパッケージ

- Duşa, A. (2019). *QCA with R: A Comprehensive Resource*. Springer. [DOI: 10.1007/978-3-319-75668-4](https://doi.org/10.1007/978-3-319-75668-4)
- Duşa, A. (2018). Consistency Cubes: A Fast, Efficient Method for Exact Boolean Minimization. *The R Journal*, 10(2), 357–370. [DOI: 10.32614/RJ-2018-080](https://doi.org/10.32614/RJ-2018-080)
- Duşa, A. (2024). *QCA: Qualitative Comparative Analysis*. R package version 3.22. https://CRAN.R-project.org/package=QCA

### 頑健性と閾値感度

- Oana, I.-E., & Schneider, C. Q. (2024). A Robustness Test Protocol for Applied QCA: Theory and R Software Application. *Sociological Methods & Research*, 53(1), 57–88. [DOI: 10.1177/00491241211036158](https://doi.org/10.1177/00491241211036158)
- Oana, I.-E., & Schneider, C. Q. (2018). SetMethods: An Add-on R Package for Advanced QCA. *The R Journal*, 10(1), 507–533. [DOI: 10.32614/RJ-2018-031](https://doi.org/10.32614/RJ-2018-031)
- Skaaning, S.-E. (2011). Assessing the Robustness of Crisp-Set and Fuzzy-Set QCA Results. *Sociological Methods & Research*, 40(2), 391–408. [DOI: 10.1177/0049124111404818](https://doi.org/10.1177/0049124111404818)
- Thiem, A., Spöhel, R., & Duşa, A. (2016). Enhancing Sensitivity Diagnostics for Qualitative Comparative Analysis: A Combinatorial Approach. *Political Analysis*, 24(1), 104–120. [DOI: 10.1093/pan/mpv028](https://doi.org/10.1093/pan/mpv028)

## 謝辞

本パッケージは、JSPS科研費 JP20K01998 の支援を受けた研究で開発された手法を実装しています。

## ライセンス

MITライセンス
