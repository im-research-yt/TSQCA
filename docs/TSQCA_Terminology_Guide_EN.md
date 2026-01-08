# QCA Terminology Guide: Distinguishing Essential Prime Implicants from Core Conditions

**TSQCA Package Supplementary Material**  
Version 1.0 | December 2025

---

## Introduction

When Qualitative Comparative Analysis (QCA) produces multiple equivalent solutions, confusion often arises about how to refer to "terms that appear in all solutions." This guide clarifies the correct terminology and provides guidelines to prevent misuse.

---

## 1. Terminology Reference Table

### 1.1 Three Key Concepts

| Concept | Comparison | Formal Term | Abbreviation |
|---------|------------|-------------|--------------|
| Appears in ALL equivalent solutions (M1, M2…) | Between equivalent solutions | **Essential Prime Implicants** | EPI |
| Appears in SOME solutions only | Between equivalent solutions | **Selective Prime Implicants** | SPI |
| Appears in BOTH parsimonious AND intermediate | Between solution types | **Core Conditions** | - |

### 1.2 Concrete Example

**Multiple solutions example:**
```
M1: A*B + C*D → Y
M2: A*B + C*E → Y
M3: A*B + D*E → Y
```

In this case:
- **Essential Prime Implicants (EPI)**: `A*B` (present in all solutions)
- **Selective Prime Implicants (SPI)**: `C*D`, `C*E`, `D*E` (present in some solutions only)

**Core Conditions example (Fiss 2011 definition):**
```
Parsimonious Solution:  A*B + C
Intermediate Solution:  A*B*~D + C*E
```

In this case:
- **Core Conditions**: A, B, C (individual **conditions** present in both solution types)
- **Peripheral Conditions**: ~D, E (individual **conditions** present only in intermediate)

---

## 2. Level of Analysis (Critical Distinction)

### 2.1 Prime Implicant Level vs. Condition Level

| Concept | Level | Object | Example |
|---------|-------|--------|---------|
| EPI / SPI | **Prime Implicant** | Configuration (conjunction of conditions) | `A*B*~C` |
| Core / Peripheral | **Condition** | Individual variable | `A`, `B`, `C` |

### 2.2 Why This Distinction Matters

- **Prime implicants** are logical conjunctions (ANDs) of multiple conditions
- **Core conditions** refer to individual condition variables
- The same word "common" applies at different analytical levels

**Incorrect usage:**
> ❌ "The core condition common to M1, M2, M3 is A*B"

**Correct usage:**
> ✓ "The essential prime implicant common to M1, M2, M3 is A*B"

---

## 3. Why NOT to Call EPIs "Necessary Conditions"

### 3.1 A Common Source of Confusion

The property of "appearing in all solutions" intuitively resembles "necessary." However:

| Term | Formal QCA Meaning | Verification Method |
|------|-------------------|---------------------|
| **Necessary Condition** | Set inclusion Y ⊆ X | **Necessity analysis** (pof function) |
| **Essential Prime Implicant** | Prime implicant in all equivalent solutions | Logical minimization result |

### 3.2 Recommendation

- **Avoid** calling EPIs "necessary conditions"
- Use "Essential Prime Implicants" — this is **methodologically safe**
- Conduct necessity analysis separately (using QCA package's `pof()` function)

---

## 4. Etymology of Terms

### 4.1 Boolean Algebra Origins

Essential Prime Implicant / Selective Prime Implicant are not QCA-specific terms.

- **Origin**: Quine-McCluskey algorithm (Boolean minimization)
- **Definition**: A prime implicant is "essential" if it uniquely covers certain truth table configurations
- **QCA Application**: Applying logical minimization to social science causal inference

### 4.2 Fiss (2011) Core/Peripheral Framework

Core Conditions / Peripheral Conditions were introduced by Fiss (2011) for fsQCA.

- **Paper**: "Building Better Causal Theories" (Academy of Management Journal)
- **Purpose**: Distinguish causal importance of conditions
- **Note**: Fiss himself states in footnote 3 that "csQCA provides little insight regarding causal configurations"

---

## 5. One-Sentence Summary

> **Terms appearing in all equivalent solutions are "Essential Prime Implicants" (EPI). Core Conditions are a separate concept defined by comparing parsimonious and intermediate solutions.**

---

## 6. Implementation in TSQCA Package

### 6.1 The `extract_mode` Parameter

```r
# Extract essential prime implicants
result <- otSweep(
  dat = data,
  outcome = "Y",
  conditions = c("A", "B", "C"),
  sweep_range = 6:9,
  thrX = c(A = 7, B = 7, C = 7),
  extract_mode = "essential"  # Essential mode
)

# View results
result$summary
# expression column: Essential prime implicants
# selective_terms column: Selective prime implicants
# n_solutions column: Number of solutions
```

### 6.2 Report Output

When using `generate_report()`, the output displays:

```
**Essential Prime Implicants (EPI)**: A*B
**Selective Prime Implicants (SPI)**: C*D, C*E
```

---

## 7. References

1. **Fiss, P. C. (2011)**. Building better causal theories: A fuzzy set approach to typologies in organization research. *Academy of Management Journal*, 54(2), 393-420.

2. **Baumgartner, M., & Thiem, A. (2017)**. Model ambiguities in configurational comparative research. *Sociological Methods & Research*, 46(4), 954-987.

3. **Oana, I. E., & Schneider, C. Q. (2024)**. A robustness test protocol for applied QCA: Theory and R software application. *Sociological Methods & Research*, 53(1), 64-104.

4. **Schneider, C. Q., & Wagemann, C. (2012)**. *Set-theoretic methods for the social sciences: A guide to qualitative comparative analysis*. Cambridge University Press.

5. **Dusa, A. (2019)**. *QCA with R: A comprehensive resource*. Springer.

---

## Revision History

| Date | Version | Changes |
|------|---------|---------|
| 2025-12-31 | 1.0 | Initial release |

---

*This document is supplementary material for the TSQCA package.*  
*GitHub: https://github.com/im-research-yt/TSQCA*
