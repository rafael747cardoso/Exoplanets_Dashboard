
### Plot the 2D Density

plot_2d_density = function(df, x_var, y_var, x_var_name, y_var_name, x_nbins, y_nbins){
    
    my_palette = list(
        list(0, "#000000"),
        list(0.25, "#E008F8"),
        list(0.5, "#F81D08"),
        list(0.75, "#F88A08"),
        list(1, "#F7FE04")
    )
    
    # Plot:
    plot_ly() %>%
    add_trace(
        data = df,
        x = ~eval(parse(text = x_var)),
        y = ~eval(parse(text = y_var)),
        type = "histogram2dcontour",
        histnorm = "probability density",
        nbinsx = x_nbins,
        nbinsy = y_nbins,
        colorscale = my_palette,
        colorbar = list(
            title = list(
                text = "<b>Density</b>",
                font = list(
                    color = "white"
                )
            ),
            tickfont = list(
                color = "white"
            )
        ),
        hovertemplate = paste0("<b>",
                               x_var_name, ": %{x:,}<br>",
                               y_var_name, ": %{y:,}<br>",
                               "Density: %{z:}</b><extra></extra>")
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
            color = "white"
        ),
        yaxis = list(
            title = paste0("<b>", y_var_name, "</b>"),
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            color = "white"
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



