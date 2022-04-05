
### Plot the missing values

plot_missing_values = function(df){
    
    df$var_name = factor(x = df$var_name,
                         levels = unique(df$var_name))
    
    my_palette = colorRampPalette(c("#F81D08", "#F7FE04"))
    plot_ly(
        data = df,
        x = ~var_name,
        y = ~non_na_pct,
        type = "bar",
        color = ~var_name,
        colors = my_palette(nrow(df)),
        hovertemplate = paste0("<b>Variable: ", df$var_name_nice, "<br>",
                               "Proportion: %{y:,} %<br>",
                               "Frequency: ", df$non_na_total, "<br>",
                               "</b><extra></extra>")
    ) %>%
    layout(
        xaxis = list(
            title = paste0("<b>Variable</b>"),
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 13
            ),
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)",
            categoryorder = "array"
        ),
        yaxis = list(
            title = "<b>Completeness (%)</b>",
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
            l = 10,
            r = 10,
            t = 50,
            b = 130
        ),
        hoverlabel = list(
            font = list(
                size = 16
            )
        ),
        plot_bgcolor = "rgba(0, 0, 0, 0)",
        paper_bgcolor = "rgba(0, 0, 0, 0)",
        showlegend = FALSE
    )

}



