
### Plot the Bubble

plot_bubble = function(df, x_var, y_var, s_var, c_var,
                       x_var_name, y_var_name, s_var_name, c_var_name){
    
    p = plot_ly()
    if(is.character(df[, c_var])){
        # Case of categoric c_var:
        lvls = unique(df[, c_var])
        n_levels = length(lvls)
        my_palette = c("#FC291C", "#FC7E1C", "#FCDE1C", "#ADFC1C", "#1CFC4C", 
                       "#1CFCE0", "#1C6DFC", "#651CFC", "#CB1CFC")
        my_palette = my_palette[1:n_levels]
        names(my_palette) = lvls
        print("ssssss")
        p = p %>%
        add_trace(
            data = df,
            x = ~eval(parse(text = x_var)),
            y = ~eval(parse(text = y_var)),
            color = ~eval(parse(text = c_var)),
            colors = my_palette,
            size = ~eval(parse(text = s_var)),
            text = ~eval(parse(text = c_var)),
            type = "scatter",
            mode = "markers",
            sizes = c(5, 30),
            marker = list(
                opacity = 0.7,
                sizemode = "diameter"
            ),
            customdata = ~eval(parse(text = s_var)),
            hovertemplate = paste0("<b>", x_var_name, ": %{x}<br>",
                                   y_var_name, ": %{y}<br>",
                                   c_var_name, ": %{text}<br>",
                                   s_var_name, ": %{customdata}</b><extra></extra>")
        )
    } else{
        # Case of numeric c_var:
        my_palette = c("#E008F8", "#F81D08", "#F88A08", "#F7FE04")
        p = p %>%
        add_trace(
            data = df,
            x = ~eval(parse(text = x_var)),
            y = ~eval(parse(text = y_var)),
            text = ~eval(parse(text = c_var)),
            type = "scatter",
            mode = "markers",
            marker = list(
                sizes = c(5, 30),
                size = ~eval(parse(text = s_var)),
                sizemode = "area",
                sizeref = 100,
                opacity = 0.7,
                color = ~eval(parse(text = y_var)),
                colors = my_palette,
                colorbar = list(
                    title = paste0("<b>", c_var_name, "</b>"),
                    len = 1
                )
            ),
            customdata = ~eval(parse(text = s_var)),
            hovertemplate = paste0("<b>", x_var_name, ": %{x}<br>",
                                   y_var_name, ": %{y}<br>",
                                   c_var_name, ": %{text}<br>",
                                   s_var_name, ": %{customdata}</b><extra></extra>")
        )
    }
    
    p = p %>%
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
                text = paste0("<br><b>", c_var_name, "</b>"),
                font = list(
                    size = 18,
                    color = "white"
                )
            )
        ),
        showlegend = TRUE
    )
    
}



