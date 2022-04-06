
### Plot the grouped violins

plot_violin = function(df, x_var, y_var, g_var, x_var_name, y_var_name, g_var_name){
    
    my_palette = colorRampPalette(c("#111539", "#97A1D9"))
    n_levels2 = length(unique(df_plot[, g_var]))
    plot_ly(
        data = df_plot,
        type = "violin",
        x = ~eval(parse(text = x_var)),
        y = ~eval(parse(text = y_var)),
        color = ~eval(parse(text = x_var)),
        colors = my_palette(n_levels2),
        spanmode = "hard",
        alpha = 1,
        box = list(
            visible = FALSE
        ),
        meanline = list(
            visible = FALSE
        ),
        points = FALSE,
        scalemode = "width"  ### this doesn't work (R plotly bug?)
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
            categoryorder = "array"
        ),
        yaxis = list(
            title = paste0("<b>", y_var_name, "</b>"),
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            )#,
            # type = "log"
        ),
        margin = list(
            l = 10,
            r = 10,
            t = 10,
            b = 10
        ),
        legend = list(
            title = list(
                text = paste0("<br><b>", g_var_name, "</b>"),
                font = list(
                    size = 18
                )
            )
        ),
        hoverlabel = list(
            font = list(
                size = 16
            )
        ),
        showlegend = TRUE
    )

    
}



