
### Plot the Pearson Correlation Matrix

plot_corrmatrix = function(df){
    
    my_palette = c("#000000", "#E008F8", "#F81D08", "#F88A08", "#F7FE04")
    plot_ly(
        data = df,
        x = ~Var1,
        y = ~Var2,
        z = ~Vars_corr,
        type = "heatmap",
        colors = my_palette,
        colorbar = list(
            title = list(
                text = "<b>Pearson correlation</b>",
                font = list(
                    color = "white"
                )
            ),
            tickfont = list(
                color = "white"
            ),
            len = 1      
        ),
        hovertemplate = paste0("<b>",
                               "%{x}<br>",
                               "%{y}<br>",
                               "Correlation: %{z:}</b><extra></extra>")
    ) %>%
    layout(
        # height = 1000,
        # width = 1500,
        xaxis = list(
            title = "",
            tickfont = list(
                size = 18
            ),
            categoryorder = "array",
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
        ),
        yaxis = list(
            title = "",
            tickfont = list(
                size = 18
            ),
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
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
        paper_bgcolor = "rgba(0, 0, 0, 0)"
    )
    


    
}



