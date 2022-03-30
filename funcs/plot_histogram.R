
### Plot the histogram

plot_histogram = function(df, x_var, x_var_name, nbins){
    
    plot_ly(
        data = df,
        x = ~eval(parse(text = x_var)),
        type = "histogram",
        histfunc = "count",
        histnorm = "",
        nbinsx = nbins,
        color = "#813DDA",
        colors = "#813DDA",
        opacity = 0.9,
        hovertemplate = paste0("<b>Counts: %{y:,}<br>",
                               x_var_name, ": %{x:,}</b><extra></extra>")
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
            gridcolor = "rgba(255, 255, 255, 0.3)"
        ),
        yaxis = list(
            title = paste0("<b>Counts</b>"),
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            color = "white",
            gridcolor = "rgba(255, 255, 255, 0.3)"
        ),
        margin = list(
            l = 10,
            r = 10,
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



