
### Plot the histogram

plot_histogram = function(df, x_var, x_var_name, nbins){
    
    # Statistics:
    x_mean = round(mean(df[, x_var], na.rm = TRUE), digits = 2)
    x_median = round(median(df[, x_var], na.rm = TRUE), digits = 2)
    x_std = round(sd(df[, x_var], na.rm = TRUE), digits = 2)
    x_skewness = round(skewness(df[, x_var], na.rm = TRUE), digits = 2)
    title_stats = paste0("<b style = 'color: #c70039'>Mean: ", x_mean, "</b>       ",
                         "<b style = 'color: #ffc300'>Median: ", x_median, "</b>       ",
                         "<b style = 'color: #C1F474'>Standard deviation: ", x_std, "</b>       ",
                         "<b style = 'color: #74F1F4'>Skewness: ", x_skewness, "</b>       ")
    vline = function(x = 0, 
                     color) {
        list(
          type = "line", 
          y0 = 0, 
          y1 = 1, 
          yref = "paper",
          x0 = x, 
          x1 = x, 
          line = list(color = color)
        )
    }
    
    # Density:
    dens = density(x = df[, x_var],
                   n = 2**13)
    
    # Plot:
    plot_ly() %>%
    add_trace(
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
    add_trace(
        x = dens$x,
        y = dens$y,
        type = "scatter",
        mode = "lines",
        line = list(
            width = 2,
            color = "#7BFD6E"
        ),
        yaxis = "y2"
    ) %>%
    layout(
        shapes = list(
            vline(
                x = x_mean,
                color = "#c70039"
            ),
            vline(
                x = x_median,
                color = "#ffc300"
            )
        ),
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
            gridcolor = "rgba(255, 255, 255, 0.15)"
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
            gridcolor = "rgba(255, 255, 255, 0.15)"
        ),
        yaxis2 = list(
            title = paste0("<b>Density</b>"),
            range = c(0, 1.1*max(dens$y)),
            overlaying = "y",
            side = "right",
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
        ),
        title = title_stats,
        margin = list(
            l = 10,
            r = 80,
            t = 60,
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



