
### Plot the grouped violins

plot_violin = function(df, x_var, y_var, x_var_name, y_var_name, plot_scale){
    
    plot_scale = ifelse(plot_scale == "Linear",
                        "linear",
                        "log")
    my_palette = c("#F81111", "#F48800", "#FFF300", "#65F002", "#0EF6F1", 
                   "#034FF2", "#C481F6", "#860AAB", "#E0008A")
    plot_ly(
        data = df,
        type = "violin",
        x = ~eval(parse(text = x_var)),
        y = ~eval(parse(text = y_var)),
        color = ~eval(parse(text = x_var)),
        colors = my_palette,
        spanmode = "hard",
        alpha = 0.7,
        box = list(
            visible = TRUE
        ),
        meanline = list(
            visible = TRUE
        ),
        points = TRUE,
        scalemode = "width"
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
            type = plot_scale,
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
        ),
        margin = list(
            l = 10,
            r = 10,
            t = 10,
            b = 10
        ),
        plot_bgcolor = "rgba(0, 0, 0, 0)",
        paper_bgcolor = "rgba(0, 0, 0, 0)",
        legend = list(
            title = list(
                text = paste0("<br><b>", x_var_name, "</b>")
            ),
            font = list(
                size = 18,
                color = "white"
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



