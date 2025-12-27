###############################################
# OTS–QCA (Y sweep) and DTS–QCA (2D sweep)
###############################################

#' OTS–QCA: Outcome threshold sweep
#'
#' Sweeps the threshold of the outcome Y while keeping the thresholds of
#' all X conditions fixed.
#'
#' @param dat Data frame containing the outcome and condition variables.
#' @param Yvar Character. Outcome variable name.
#' @param Xvars Character vector. Names of condition variables.
#' @param sweep_range Numeric vector. Candidate thresholds for Y.
#' @param thrX Named numeric vector. Fixed thresholds for X variables,
#'   with names matching \code{Xvars}.
#' @param dir.exp Directional expectations for \code{minimize}.
#'   If \code{NULL}, all set to 1.
#' @param include Inclusion rule for \code{minimize}.
#' @param incl.cut Consistency cutoff for \code{truthTable}.
#' @param n.cut Frequency cutoff for \code{truthTable}.
#' @param pri.cut PRI cutoff for \code{minimize}.
#' @param extract_mode Character. How to handle multiple solutions:
#'   \code{"first"} (default), \code{"all"}, or \code{"core"}.
#'   See \code{\link{qca_extract}} for details.
#' @param return_details Logical. If \code{TRUE} (default), returns both
#'   summary and detailed objects for use with \code{generate_report()}.
#'
#' @return
#' If \code{return_details = FALSE}, a data frame with columns:
#' \itemize{
#'   \item \code{thrY} — threshold for Y
#'   \item \code{expression} — minimized solution expression
#'   \item \code{inclS} — solution consistency
#'   \item \code{covS} — solution coverage
#'   \item (additional columns depending on \code{extract_mode})
#' }
#'
#' If \code{return_details = TRUE}, a list with:
#' \itemize{
#'   \item \code{summary} — the data frame above
#'   \item \code{details} — per-Y-threshold list of
#'     \code{thrY}, \code{thrX_vec}, \code{truth_table}, \code{solution}
#' }
#'
#' @importFrom QCA truthTable minimize
#' @export
#' @examples
#' # Load sample data
#' data(sample_data)
#' 
#' # Set fixed thresholds for conditions
#' thrX <- c(X1 = 7, X2 = 7, X3 = 7)
#' 
#' # Run outcome threshold sweep
#' result <- otSweep(
#'   dat = sample_data,
#'   Yvar = "Y",
#'   Xvars = c("X1", "X2", "X3"),
#'   sweep_range = 6:9,
#'   thrX = thrX
#' )
#' head(result$summary)
otSweep <- function(dat, Yvar, Xvars,
                    sweep_range, thrX,
                    dir.exp = NULL, include = "?",
                    incl.cut = 0.8, n.cut = 1, pri.cut = 0,
                    extract_mode = c("first", "all", "core"),
                    return_details = TRUE) {
  
  extract_mode <- match.arg(extract_mode)
  
  # Initialize output data frame based on extract_mode
  df_out <- data.frame(
    thrY       = numeric(0),
    expression = character(0),
    inclS      = numeric(0),
    covS       = numeric(0),
    n_solutions = integer(0),
    stringsAsFactors = FALSE
  )
  
  # Add columns based on extract_mode
  if (extract_mode == "core") {
    df_out$peripheral_terms <- character(0)
    df_out$unique_terms     <- character(0)
  }
  
  details_list <- list()
  
  # Track thresholds with multiple solutions (for warning in "first" mode)
  multi_sol_thresholds <- c()
  
  # Handle dir.exp: NULL or scalar -> expand to vector (before loop)
  local_dir.exp <- dir.exp
  if (is.null(local_dir.exp) || length(local_dir.exp) == 1) {
    local_dir.exp <- rep(if (is.null(dir.exp)) 1 else dir.exp[1], length(Xvars))
    names(local_dir.exp) <- Xvars
  }
  
  for (thrY in sweep_range) {
    
    dat_bin <- data.frame(Y = qca_bin(dat[[Yvar]], thrY))
    for (x in Xvars) {
      dat_bin[[x]] <- qca_bin(dat[[x]], thrX[x])
    }
    
    tt <- try(
      QCA::truthTable(
        dat_bin,
        outcome    = "Y",
        conditions = Xvars,
        show.cases = FALSE,
        incl.cut1  = incl.cut,
        n.cut      = n.cut,
        pri.cut    = pri.cut
      ),
      silent = TRUE
    )
    
    if (inherits(tt, "try-error")) {
      new_row <- data.frame(
        thrY        = thrY,
        expression  = "No solution",
        inclS       = NA_real_,
        covS        = NA_real_,
        n_solutions = 0L,
        stringsAsFactors = FALSE
      )
      
      if (extract_mode == "core") {
        new_row$peripheral_terms <- NA_character_
        new_row$unique_terms     <- NA_character_
      }
      
      df_out <- rbind(df_out, new_row)
      
      if (return_details) {
        details_list[[as.character(thrY)]] <- list(
          thrY        = thrY,
          thrX_vec    = thrX,
          truth_table = NULL,
          solution    = NULL,
          dat_bin     = NULL
        )
      }
      next
    }
    
    sol <- try(
      QCA::minimize(
        tt,
        include    = include,
        dir.exp    = local_dir.exp,
        details    = TRUE,
        show.cases = FALSE,
        pri.cut    = pri.cut
      ),
      silent = TRUE
    )
    
    if (inherits(sol, "try-error")) {
      new_row <- data.frame(
        thrY        = thrY,
        expression  = "No solution",
        inclS       = NA_real_,
        covS        = NA_real_,
        n_solutions = 0L,
        stringsAsFactors = FALSE
      )
      
      if (extract_mode == "core") {
        new_row$peripheral_terms <- NA_character_
        new_row$unique_terms     <- NA_character_
      }
      
      df_out <- rbind(df_out, new_row)
      
      if (return_details) {
        details_list[[as.character(thrY)]] <- list(
          thrY        = thrY,
          thrX_vec    = thrX,
          truth_table = tt,
          solution    = NULL,
          dat_bin     = dat_bin
        )
      }
      next
    }
    
    info <- qca_extract(sol, extract_mode = extract_mode)
    
    # Track multiple solutions (for warning)
    if (info$n_solutions > 1) {
      multi_sol_thresholds <- c(multi_sol_thresholds, thrY)
    }
    
    # Build result row based on extract_mode
    new_row <- data.frame(
      thrY        = thrY,
      expression  = info$expression,
      inclS       = info$inclS,
      covS        = info$covS,
      n_solutions = info$n_solutions,
      stringsAsFactors = FALSE
    )
    
    if (extract_mode == "core") {
      new_row$peripheral_terms <- info$peripheral_terms
      new_row$unique_terms     <- info$unique_terms
    }
    
    df_out <- rbind(df_out, new_row)
    
    if (return_details) {
      details_list[[as.character(thrY)]] <- list(
        thrY        = thrY,
        thrX_vec    = thrX,
        truth_table = tt,
        solution    = sol,
        dat_bin     = dat_bin
      )
    }
  }
  
  # Issue warning for multiple solutions
  if (length(multi_sol_thresholds) > 0) {
    warning(
      "Multiple intermediate solutions exist for thrY = ",
      paste(multi_sol_thresholds, collapse = ", "),
      " (n_solutions > 1). ",
      "Only the first solution (M1) and its fit metrics are shown. ",
      "Use generate_report() for full analysis.",
      call. = FALSE
    )
  }
  
  if (return_details) {
    return(list(
      summary = df_out, 
      details = details_list,
      params = list(
        Yvar = Yvar,
        Xvars = Xvars,
        thrX = thrX,
        sweep_range = sweep_range,
        incl.cut = incl.cut,
        n.cut = n.cut,
        pri.cut = pri.cut,
        include = include,
        dir.exp = local_dir.exp
      )
    ))
  }
  
  df_out
}


###############################################
# DTS–QCA (2D sweep)
###############################################

#' DTS–QCA: Two-dimensional X–Y threshold sweep
#'
#' Sweeps thresholds for multiple X variables and the outcome Y jointly.
#' For each combination of X thresholds and each candidate Y threshold, the
#' data are binarized and a crisp-set QCA is executed.
#'
#' @param dat Data frame containing the outcome and condition variables.
#' @param Yvar Character. Outcome variable name.
#' @param Xvars Character vector. Names of condition variables.
#' @param sweep_list_X Named list. Each element is a numeric vector of
#'   candidate thresholds for the corresponding X.
#' @param sweep_range_Y Numeric vector. Candidate thresholds for Y.
#' @param dir.exp Directional expectations for \code{minimize}.
#'   If \code{NULL}, all set to 1.
#' @param include Inclusion rule for \code{minimize}.
#' @param incl.cut Consistency cutoff for \code{truthTable}.
#' @param n.cut Frequency cutoff for \code{truthTable}.
#' @param pri.cut PRI cutoff for \code{minimize}.
#' @param extract_mode Character. How to handle multiple solutions:
#'   \code{"first"} (default), \code{"all"}, or \code{"core"}.
#'   See \code{\link{qca_extract}} for details.
#' @param return_details Logical. If \code{TRUE} (default), returns both
#'   summary and detailed objects for use with \code{generate_report()}.
#'
#' @return
#' If \code{return_details = FALSE}, a data frame with columns:
#' \itemize{
#'   \item \code{combo_id} — index of the X-threshold combination
#'   \item \code{thrY} — threshold for Y
#'   \item \code{thrX} — character label summarizing the X thresholds
#'   \item \code{expression} — minimized solution expression
#'   \item \code{inclS} — solution consistency
#'   \item \code{covS} — solution coverage
#'   \item (additional columns depending on \code{extract_mode})
#' }
#'
#' If \code{return_details = TRUE}, a list with:
#' \itemize{
#'   \item \code{summary} — the data frame above
#'   \item \code{details} — list of runs with
#'     \code{combo_id}, \code{thrY}, \code{thrX_vec},
#'     \code{truth_table}, \code{solution}
#' }
#'
#' @importFrom QCA truthTable minimize
#' @examples
#' # Load sample data
#' data(sample_data)
#' 
#' # Quick demonstration with reduced complexity (< 5 seconds)
#' # Using 2 conditions and 2 threshold levels
#' sweep_list_X <- list(
#'   X1 = 6:7,  # Reduced from 6:8 to 6:7
#'   X2 = 6:7   # Reduced from 6:8 to 6:7
#' )
#' 
#' sweep_range_Y <- 6:7  # Reduced from 6:8 to 6:7
#' 
#' # Run dual threshold sweep with reduced parameters
#' # This explores 2 × 2^2 = 8 threshold combinations
#' result_quick <- dtSweep(
#'   dat = sample_data,
#'   Yvar = "Y",
#'   Xvars = c("X1", "X2"),  # Reduced from 3 to 2 conditions
#'   sweep_list_X = sweep_list_X,
#'   sweep_range_Y = sweep_range_Y
#' )
#' head(result_quick$summary)
#' 
#' \donttest{
#' # Full analysis with all conditions and thresholds
#' # This explores 3 × 3^3 = 81 threshold combinations (takes ~10-15 seconds)
#' sweep_list_X_full <- list(
#'   X1 = 6:8,
#'   X2 = 6:8,
#'   X3 = 6:8
#' )
#' 
#' sweep_range_Y_full <- 6:8
#' 
#' result_full <- dtSweep(
#'   dat = sample_data,
#'   Yvar = "Y",
#'   Xvars = c("X1", "X2", "X3"),
#'   sweep_list_X = sweep_list_X_full,
#'   sweep_range_Y = sweep_range_Y_full
#' )
#' 
#' # Analyze threshold-dependent causal structures
#' head(result_full$summary)
#' }
#' @export
dtSweep <- function(dat, Yvar, Xvars,
                    sweep_list_X, sweep_range_Y,
                    dir.exp = NULL, include = "?",
                    incl.cut = 0.8, n.cut = 1, pri.cut = 0,
                    extract_mode = c("first", "all", "core"),
                    return_details = TRUE) {
  
  extract_mode <- match.arg(extract_mode)
  
  combo_X <- expand.grid(
    sweep_list_X,
    KEEP.OUT.ATTRS  = FALSE,
    stringsAsFactors = FALSE
  )
  
  # Initialize output data frame based on extract_mode
  df_out <- data.frame(
    combo_id    = integer(0),
    thrY        = numeric(0),
    thrX        = character(0),
    expression  = character(0),
    inclS       = numeric(0),
    covS        = numeric(0),
    n_solutions = integer(0),
    stringsAsFactors = FALSE
  )
  
  # Add columns based on extract_mode
  if (extract_mode == "core") {
    df_out$peripheral_terms <- character(0)
    df_out$unique_terms     <- character(0)
  }
  
  details_list <- list()
  
  # Handle dir.exp: NULL or scalar -> expand to vector
  if (is.null(dir.exp) || length(dir.exp) == 1) {
    dir.exp <- rep(if (is.null(dir.exp)) 1 else dir.exp[1], length(Xvars))
    names(dir.exp) <- Xvars
  }
  
  # Track combinations with multiple solutions (for warning in "first" mode)
  multi_sol_combos <- c()
  
  combo_id <- 1L
  
  for (i in seq_len(nrow(combo_X))) {
    
    thrX_vec <- as.numeric(combo_X[i, ])
    names(thrX_vec) <- names(combo_X)
    thrX_label <- paste(names(thrX_vec), thrX_vec,
                        sep = "=", collapse = ", ")
    
    for (thrY in sweep_range_Y) {
      
      dat_bin <- data.frame(Y = qca_bin(dat[[Yvar]], thrY))
      for (x in Xvars) {
        dat_bin[[x]] <- qca_bin(dat[[x]], thrX_vec[x])
      }
      
      tt <- try(
        QCA::truthTable(
          dat_bin,
          outcome    = "Y",
          conditions = Xvars,
          show.cases = FALSE,
          incl.cut1  = incl.cut,
          n.cut      = n.cut,
          pri.cut    = pri.cut
        ),
        silent = TRUE
      )
      
      if (inherits(tt, "try-error")) {
        new_row <- data.frame(
          combo_id    = combo_id,
          thrY        = thrY,
          thrX        = thrX_label,
          expression  = "No solution",
          inclS       = NA_real_,
          covS        = NA_real_,
          n_solutions = 0L,
          stringsAsFactors = FALSE
        )
        
        if (extract_mode == "core") {
          new_row$peripheral_terms <- NA_character_
          new_row$unique_terms     <- NA_character_
        }
        
        df_out <- rbind(df_out, new_row)
        
        if (return_details) {
          details_list[[length(details_list) + 1L]] <- list(
            combo_id    = combo_id,
            thrY        = thrY,
            thrX_vec    = thrX_vec,
            truth_table = NULL,
            solution    = NULL,
            dat_bin     = NULL
          )
        }
        
        next
      }
      
      sol <- try(
        QCA::minimize(
          tt,
          include    = include,
          dir.exp    = dir.exp,
          details    = TRUE,
          show.cases = FALSE,
          pri.cut    = pri.cut
        ),
        silent = TRUE
      )
      
      if (inherits(sol, "try-error")) {
        new_row <- data.frame(
          combo_id    = combo_id,
          thrY        = thrY,
          thrX        = thrX_label,
          expression  = "No solution",
          inclS       = NA_real_,
          covS        = NA_real_,
          n_solutions = 0L,
          stringsAsFactors = FALSE
        )
        
        if (extract_mode == "core") {
          new_row$peripheral_terms <- NA_character_
          new_row$unique_terms     <- NA_character_
        }
        
        df_out <- rbind(df_out, new_row)
        
        if (return_details) {
          details_list[[length(details_list) + 1L]] <- list(
            combo_id    = combo_id,
            thrY        = thrY,
            thrX_vec    = thrX_vec,
            truth_table = tt,
            solution    = NULL,
            dat_bin     = dat_bin
          )
        }
        
        next
      }
      
      info <- qca_extract(sol, extract_mode = extract_mode)
      
      # Track multiple solutions
      if (info$n_solutions > 1) {
        multi_sol_combos <- c(multi_sol_combos, 
                              paste0("combo_id=", combo_id, ", thrY=", thrY))
      }
      
      # Build result row based on extract_mode
      new_row <- data.frame(
        combo_id    = combo_id,
        thrY        = thrY,
        thrX        = thrX_label,
        expression  = info$expression,
        inclS       = info$inclS,
        covS        = info$covS,
        n_solutions = info$n_solutions,
        stringsAsFactors = FALSE
      )
      
      if (extract_mode == "core") {
        new_row$peripheral_terms <- info$peripheral_terms
        new_row$unique_terms     <- info$unique_terms
      }
      
      df_out <- rbind(df_out, new_row)
      
      if (return_details) {
        details_list[[length(details_list) + 1L]] <- list(
          combo_id    = combo_id,
          thrY        = thrY,
          thrX_vec    = thrX_vec,
          truth_table = tt,
          solution    = sol,
          dat_bin     = dat_bin
        )
      }
    }
    
    combo_id <- combo_id + 1L
  }
  
  # Issue warning for multiple solutions
  if (length(multi_sol_combos) > 0) {
    n_multi <- length(multi_sol_combos)
    warning(
      "Multiple intermediate solutions exist for ", n_multi, " combination(s) ",
      "(n_solutions > 1). ",
      "Only the first solution (M1) and its fit metrics are shown. ",
      "Use generate_report() for full analysis.",
      call. = FALSE
    )
  }
  
  if (return_details) {
    return(list(
      summary = df_out, 
      details = details_list,
      params = list(
        Yvar = Yvar,
        Xvars = Xvars,
        sweep_list_X = sweep_list_X,
        sweep_range_Y = sweep_range_Y,
        incl.cut = incl.cut,
        n.cut = n.cut,
        pri.cut = pri.cut,
        include = include,
        dir.exp = dir.exp
      )
    ))
  }
  
  df_out
}