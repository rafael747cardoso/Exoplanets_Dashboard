
### Plot the Bubble

plot_bubble = function(df, x_var, y_var, s_var, c_var,
                       x_var_name, y_var_name, s_var_name, c_var_name){
    
    # Case of categoric (<-10) c_var:
    lvls = unique(df[, c_var])
    n_levels = length(lvls)
    my_palette = c("#c70039", "#2a7b9b", "#eddd53")
    names(my_palette) = lvls
    
    
    # Case of numeric c_var:
    
    

    # Plot:
    plot_ly() %>%
    add_trace(
        data = df_plot,
        x = ~eval(parse(text = x_var)),
        y = ~eval(parse(text = y_var)),
        color = ~eval(parse(text = c_var)),
        colors = my_palette,
        size = ~eval(parse(text = s_var)),
        text = ~color_var,
        type = "scatter",
        mode = "markers",
        sizes = c(5, 30),
        marker = list(
            opacity = 0.5,
            sizemode = 'diameter'
        ),
        customdata = ~eval(parse(text = size_var)),
        hovertemplate = paste0("<b>", x_var_name, ": %{x}<br>",
                               y_var_name, ": %{y}<br>",
                               color_var_name, ": %{text}<br>",
                               size_var_name, ": %{customdata}</b><extra></extra>")
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
        legend = list(
            title = list(
                text = paste0("<br><b>", color_var_name, "</b>"),
                font = list(
                    size = 18
                )
            )
        ),
        showlegend = TRUE
    )
    
}



