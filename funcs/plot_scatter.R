
### Plot the Scatter with errors

plot_scatter = function(df, x_var, y_var, x_var_name, y_var_name){
    
    # Take the mean error:
    x_vars = names(df)[grepl(x = names(df),
                             pattern = x_var)]
    if(sum(grepl(x = x_vars,
                 pattern = "_error_")) == 2){
        x_var_error = (df[, paste0(x_var, "_error_min")] + df[, paste0(x_var, "_error_max")])/2
    } else{
        x_var_error = NA
    }
    y_vars = names(df)[grepl(x = names(df),
                             pattern = y_var)]
    if(sum(grepl(x = y_vars,
                 pattern = "_error_")) == 2){
        y_var_error = (df[, paste0(y_var, "_error_min")] + df[, paste0(y_var, "_error_max")])/2
    } else{
        y_var_error = NA
    }
    df$x_var_error = x_var_error
    df$y_var_error = y_var_error
    
    # Plot:
    plot_ly() %>%
    add_trace(
        data = df,
        x = ~eval(parse(text = x_var)),
        y = ~eval(parse(text = y_var)),
        error_x = ~list(
            array = x_var_error,
            color = "rgba(26, 186, 238, 0.3)",
            width = 0
        ),
        error_y = ~list(
            array = y_var_error,
            color = "rgba(26, 186, 238, 0.3)",
            width = 0
        ),
        type = "scatter",
        mode = "markers",
        marker = list(
            size = 5,
            color = "#50EE1A"
        ),
        hovertemplate = paste0("<b>", x_var_name, ": %{x}<br>",
                               y_var_name, ": %{y}</b><extra></extra>")
    ) %>%
    layout(
        xaxis = list(
            title = paste0("<b>", x_var_name, "</b>"),
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            categoryorder = "array",
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
        ),
        yaxis = list(
            title = paste0("<b>", y_var_name, "</b>"),
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
        ),
        margin = list(
            l = 50,
            r = 50,
            t = 10,
            b = 10
        ),
        hoverlabel = list(
            font = list(
                size = 18
            )
        ),
        plot_bgcolor = "rgba(0, 0, 0, 0)",
        paper_bgcolor = "rgba(0, 0, 0, 0)",
        showlegend = FALSE
    )
    
}



