###############################################
# Helper functions for TSQCA
###############################################

#' Extract all metrics from QCA solution object
#'
#' Safely extracts solution-level and term-level metrics from
#' various QCA solution object structures. Handles cases where
#' multiple solutions exist and sol.incl.cov may be NULL.
#'
#' @param IC IC object from QCA solution.
#' @param sol_obj Full solution object (optional, for fallback).
#'
#' @return List with elements:
#'   \itemize{
#'     \item \code{sol_inclS} — solution consistency (or NA)
#'     \item \code{sol_PRI} — solution PRI (or NA)
#'     \item \code{sol_covS} — solution coverage (or NA)
#'     \item \code{term_df} — data frame of per-term metrics (or NULL)
#'   }
#' @keywords internal
extract_all_metrics <- function(IC, sol_obj = NULL) {
  
  result <- list(
    sol_inclS = NA_real_,
    sol_PRI   = NA_real_,
    sol_covS  = NA_real_,
    term_df   = NULL
  )
  
  # Try to get from IC directly
  if (!is.null(IC)) {
    
    # Method 1: sol.incl.cov (single solution case)
    if ("sol.incl.cov" %in% names(IC)) {
      sol <- IC$sol.incl.cov
      if (!is.null(sol$inclS)) result$sol_inclS <- sol$inclS[1]
      if (!is.null(sol$PRI)) result$sol_PRI <- sol$PRI[1]
      if (!is.null(sol$covS)) result$sol_covS <- sol$covS[1]
    }
    
    # Method 2: overall (multiple solutions case)
    if (is.na(result$sol_inclS) && "overall" %in% names(IC)) {
      overall <- IC$overall
      if (is.list(overall)) {
        if ("sol.incl.cov" %in% names(overall)) {
          sol <- overall$sol.incl.cov
          if (!is.null(sol$inclS)) result$sol_inclS <- sol$inclS[1]
          if (!is.null(sol$PRI)) result$sol_PRI <- sol$PRI[1]
          if (!is.null(sol$covS)) result$sol_covS <- sol$covS[1]
        }
        if (is.na(result$sol_inclS) && !is.null(overall$inclS)) {
          result$sol_inclS <- overall$inclS[1]
        }
        if (is.na(result$sol_PRI) && !is.null(overall$PRI)) {
          result$sol_PRI <- overall$PRI[1]
        }
        if (is.na(result$sol_covS) && !is.null(overall$covS)) {
          result$sol_covS <- overall$covS[1]
        }
      }
    }
    
    # Method 3: individual (multiple solutions, first solution metrics)
    if (is.na(result$sol_inclS) && "individual" %in% names(IC)) {
      indiv <- IC$individual
      if (is.list(indiv) && length(indiv) > 0) {
        first_indiv <- indiv[[1]]
        if (is.list(first_indiv)) {
          if ("sol.incl.cov" %in% names(first_indiv)) {
            sol <- first_indiv$sol.incl.cov
            if (!is.null(sol$inclS)) result$sol_inclS <- sol$inclS[1]
            if (!is.null(sol$PRI)) result$sol_PRI <- sol$PRI[1]
            if (!is.null(sol$covS)) result$sol_covS <- sol$covS[1]
          }
          if (is.null(result$term_df) && "incl.cov" %in% names(first_indiv)) {
            result$term_df <- first_indiv$incl.cov
          }
        }
      }
    }
    
    # Get per-term metrics (incl.cov)
    if (is.null(result$term_df) && "incl.cov" %in% names(IC)) {
      result$term_df <- IC$incl.cov
    }
    
    # If we got values, return
    if (!is.na(result$sol_inclS)) return(result)
  }
  
  # Fallback: try to get from sol_obj
  if (!is.null(sol_obj)) {
    
    # Method 4: sol_obj$IC
    if (!is.null(sol_obj$IC)) {
      IC <- sol_obj$IC
      
      if ("overall" %in% names(IC)) {
        overall <- IC$overall
        if (is.list(overall)) {
          if ("sol.incl.cov" %in% names(overall)) {
            sol <- overall$sol.incl.cov
            if (!is.null(sol$inclS)) result$sol_inclS <- sol$inclS[1]
            if (!is.null(sol$PRI)) result$sol_PRI <- sol$PRI[1]
            if (!is.null(sol$covS)) result$sol_covS <- sol$covS[1]
          }
          if (is.na(result$sol_inclS) && !is.null(overall$inclS)) {
            result$sol_inclS <- overall$inclS[1]
          }
          if (is.na(result$sol_PRI) && !is.null(overall$PRI)) {
            result$sol_PRI <- overall$PRI[1]
          }
          if (is.na(result$sol_covS) && !is.null(overall$covS)) {
            result$sol_covS <- overall$covS[1]
          }
        }
      }
      
      if (is.na(result$sol_inclS) && "individual" %in% names(IC)) {
        indiv <- IC$individual
        if (is.list(indiv) && length(indiv) > 0) {
          first_indiv <- indiv[[1]]
          if (is.list(first_indiv)) {
            if ("sol.incl.cov" %in% names(first_indiv)) {
              sol <- first_indiv$sol.incl.cov
              if (!is.null(sol$inclS)) result$sol_inclS <- sol$inclS[1]
              if (!is.null(sol$PRI)) result$sol_PRI <- sol$PRI[1]
              if (!is.null(sol$covS)) result$sol_covS <- sol$covS[1]
            }
            if (is.null(result$term_df) && "incl.cov" %in% names(first_indiv)) {
              result$term_df <- first_indiv$incl.cov
            }
          }
        }
      }
    }
    
    # Method 5: i.sol (named list: C1P1, C1P2, etc.)
    if (is.na(result$sol_inclS) && !is.null(sol_obj$i.sol) && length(sol_obj$i.sol) > 0) {
      first_isol <- sol_obj$i.sol[[1]]
      if (!is.null(first_isol$IC)) {
        IC_isol <- first_isol$IC
        if ("sol.incl.cov" %in% names(IC_isol)) {
          sol <- IC_isol$sol.incl.cov
          if (!is.null(sol$inclS)) result$sol_inclS <- sol$inclS[1]
          if (!is.null(sol$PRI)) result$sol_PRI <- sol$PRI[1]
          if (!is.null(sol$covS)) result$sol_covS <- sol$covS[1]
        }
        if (is.null(result$term_df) && "incl.cov" %in% names(IC_isol)) {
          result$term_df <- IC_isol$incl.cov
        }
      }
    }
  }
  
  return(result)
}


#' Convert data frame to Markdown table
#'
#' @param df Data frame to convert.
#' @param digits Number of decimal places for numeric columns.
#'
#' @return Character string of Markdown table.
#' @keywords internal
df_to_md_table <- function(df, digits = 3) {
  if (is.null(df) || nrow(df) == 0) return("(No data)\n")
  
  # Round numeric columns
  for (col in names(df)) {
    if (is.numeric(df[[col]])) {
      df[[col]] <- round(df[[col]], digits)
    }
  }
  
  # Convert all to character for consistent output
  df <- as.data.frame(lapply(df, as.character), stringsAsFactors = FALSE)
  
  # Build header
  header <- paste0("| ", paste(names(df), collapse = " | "), " |")
  separator <- paste0("|", paste(rep("---", ncol(df)), collapse = "|"), "|")
  
  # Build rows
  rows <- apply(df, 1, function(row) {
    paste0("| ", paste(row, collapse = " | "), " |")
  })
  
  paste(c(header, separator, rows), collapse = "\n")
}


#' Split solution expression into terms
#'
#' @param solution Character. Solution expression (e.g., "X1*X2 + X3").
#'
#' @return Character vector of terms.
#' @keywords internal
split_solution_terms <- function(solution) {
  if (is.null(solution) || is.na(solution) || solution == "" || 
      solution == "No solution" || solution == "No core terms") {
    return(character(0))
  }
  trimws(unlist(strsplit(solution, " \\+ ")))
}


#' Get all unique terms from multiple solutions
#'
#' @param sol_list List of solution character vectors from minimize().
#'
#' @return List with:
#'   \itemize{
#'     \item \code{all_terms} — all terms (with duplicates)
#'     \item \code{unique_terms} — unique terms
#'     \item \code{term_counts} — table of term frequencies
#'   }
#' @keywords internal
get_all_terms <- function(sol_list) {
  if (is.null(sol_list) || length(sol_list) == 0) {
    return(list(
      all_terms    = character(0),
      unique_terms = character(0),
      term_counts  = table(character(0))
    ))
  }
  
  # Extract terms from each solution
  all_terms <- unlist(lapply(sol_list, function(sol) {
    split_solution_terms(paste(sol, collapse = " + "))
  }))
  
  list(
    all_terms    = all_terms,
    unique_terms = unique(all_terms),
    term_counts  = table(all_terms)
  )
}