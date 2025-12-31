# QCA用語整理：複数解と必須主項・コア条件の区別

**TSQCA パッケージ 補足資料**  
Version 1.0 | 2025年12月

---

## はじめに

質的比較分析（QCA）で複数の等価な解が得られた場合、「すべての解に共通する項」をどう呼ぶかについて、文献上で用語の混乱が見られます。本資料では、正確な用語法を整理し、誤用を防ぐためのガイドラインを提供します。

---

## 1. 用語の対応表

### 1.1 三つの主要概念

| 概念 | 比較対象 | 正式名称（英） | 日本語 | 略称 |
|------|----------|----------------|--------|------|
| 複数解（M1, M2…）のすべてに共通 | 等価な解どうし | **Essential Prime Implicants** | **必須主項** | EPI |
| 一部の解にのみ含まれる | 等価な解どうし | **Selective Prime Implicants** | **選択的主項** | SPI |
| 簡略解と中間解の両方に現れる | 解タイプの比較 | **Core Conditions** | **コア条件** | - |

### 1.2 具体例

**複数解の例：**
```
M1: A*B + C*D → Y
M2: A*B + C*E → Y
M3: A*B + D*E → Y
```

この場合：
- **必須主項（EPI）**: `A*B`（全ての解に含まれる）
- **選択的主項（SPI）**: `C*D`, `C*E`, `D*E`（一部の解にのみ含まれる）

**コア条件の例（Fiss 2011の定義）：**
```
簡略解（Parsimonious）:  A*B + C
中間解（Intermediate）:  A*B*~D + C*E
```

この場合：
- **コア条件**: A, B, C（両方の解タイプに現れる**条件**）
- **周辺条件**: ~D, E（中間解のみに現れる**条件**）

---

## 2. レベルの違い（重要）

### 2.1 主項レベル vs 条件レベル

| 概念 | レベル | 対象 | 例 |
|------|--------|------|-----|
| EPI / SPI | **主項**（Prime Implicant） | 積項・構成（configuration） | `A*B*~C` |
| コア条件 / 周辺条件 | **条件**（Condition） | 個別の変数 | `A`, `B`, `C` |

### 2.2 なぜこの区別が重要か

- **主項**は複数の条件の論理積（AND）で構成される
- **コア条件**は個々の条件変数を指す
- 同じ「共通」でも、何が共通かのレベルが異なる

**混同の例（誤り）：**
> ❌「M1, M2, M3に共通するコア条件は A*B である」

**正しい表現：**
> ✓「M1, M2, M3に共通する必須主項は A*B である」

---

## 3. 「必要条件」と呼ばない理由

### 3.1 誤解が生じやすい表現

「すべての解に共通して現れる」という性質は、直感的に「必要条件」に見えます。しかし：

| 用語 | QCAでの正式な意味 | 検証方法 |
|------|-------------------|----------|
| **必要条件（Necessary Condition）** | 集合包含 Y ⊆ X を満たす条件 | **必要条件分析**（pof関数） |
| **必須主項（EPI）** | すべての等価解に含まれる主項 | 論理最小化の結果 |

### 3.2 推奨

- 必須主項を「必要条件」と呼ぶのは**避ける**
- 「必須主項（Essential Prime Implicant）」で止めるのが**安全**
- 必要条件分析は別途実施する（QCAパッケージの`pof()`関数など）

---

## 4. 用語の由来

### 4.1 ブール代数からの継承

Essential Prime Implicant / Selective Prime Implicant は、QCA固有の用語ではありません。

- **由来**: ブール代数のQuine-McCluskey法（論理最小化アルゴリズム）
- **定義**: 真理表の特定の構成を「唯一」カバーできる主項が「必須」
- **QCAへの応用**: 社会科学の因果推論に論理最小化を適用

### 4.2 Fiss (2011) のコア/周辺

Core Conditions / Peripheral Conditions は、Fiss (2011) がfsQCA用に導入した概念です。

- **論文**: "Building Better Causal Theories" (Academy of Management Journal)
- **目的**: 条件の因果的重要性を区別する
- **注意**: Fiss自身が脚注3で「csQCAは因果的構成についてほとんど洞察を与えない」と述べている

---

## 5. 一文での最終整理

> **複数解に共通して現れるのは「必須主項（Essential Prime Implicants）」であり、コア条件（Core Conditions）とは、簡略解と中間解の比較によって定義される別概念である。**

---

## 6. TSQCAパッケージでの実装

### 6.1 `extract_mode` パラメータ

```r
# 必須主項を抽出
result <- otSweep(
  dat = data,
  outcome = "Y",
  conditions = c("A", "B", "C"),
  sweep_range = 6:9,
  thrX = c(A = 7, B = 7, C = 7),
  extract_mode = "essential"  # 必須主項モード
)

# 結果の確認
result$summary
# expression列: 必須主項
# selective_terms列: 選択的主項
# n_solutions列: 解の数
```

### 6.2 レポート出力

`generate_report()` では以下のように表示されます：

```
**Essential Prime Implicants (EPI)**: A*B
**Selective Prime Implicants (SPI)**: C*D, C*E
```

---

## 7. 参考文献

1. **Fiss, P. C. (2011)**. Building better causal theories: A fuzzy set approach to typologies in organization research. *Academy of Management Journal*, 54(2), 393-420.

2. **Baumgartner, M., & Thiem, A. (2017)**. Model ambiguities in configurational comparative research. *Sociological Methods & Research*, 46(4), 954-987.

3. **Oana, I. E., & Schneider, C. Q. (2024)**. A robustness test protocol for applied QCA: Theory and R software application. *Sociological Methods & Research*, 53(1), 64-104.

4. **Schneider, C. Q., & Wagemann, C. (2012)**. *Set-theoretic methods for the social sciences: A guide to qualitative comparative analysis*. Cambridge University Press.

5. **Dusa, A. (2019)**. *QCA with R: A comprehensive resource*. Springer.

---

## 更新履歴

| 日付 | バージョン | 内容 |
|------|------------|------|
| 2025-12-31 | 1.0 | 初版作成 |

---

*本資料はTSQCAパッケージの補足資料として作成されました。*  
*GitHub: https://github.com/im-research-yt/TSQCA*
