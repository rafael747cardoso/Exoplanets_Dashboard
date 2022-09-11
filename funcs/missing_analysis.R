
### Missing analysis

missing_analysis = function(df){
    
    # Replace empties by NA:
    for(i in 1:ncol(df)){
        df[, i] = ifelse(trimws(df[, i]) == "",
                         NA,
                         df[, i])
    }
    
    # Frequency of non-NAs by variable:
    df_miss = df %>%
                  dplyr::filter(1 == 2) %>%
                  t() %>%
                  as.data.frame()
    df_miss$var_name = colnames(df)
    row.names(df_miss) = 1:nrow(df_miss)
    df_miss$non_na_total = NA
    df_miss$non_na_pct = NA

    for(i in 1:ncol(df)){
        non_na_abs = sum(!is.na(df[, i]))
        df_miss$non_na_total[i] = non_na_abs
        df_miss$non_na_pct[i] = round(x = 100*non_na_abs/nrow(df),
                                      digits = 2)
    }
    
    # Order by total non-NAs:
    df_miss = df_miss %>% 
                  dplyr::arrange(desc(non_na_total))
    
    # Preserve the order:
    df_miss$var_name = factor(x = df_miss$var_name,
                              levels = df_miss$var_name)
    
    return(df_miss)
}

