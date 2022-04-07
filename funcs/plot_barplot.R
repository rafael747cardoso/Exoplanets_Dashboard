
### Plot the Pareto Barplot

plot_barplot = function(df, x_var_name){
    
    my_palette = c("#F81111", "#F48800", "#FFF300", "#65F002", "#0EF6F1", 
                   "#034FF2", "#C481F6", "#860AAB", "#E0008A")
    plot_ly() %>%
    add_trace(
        data = df,
        x = ~level,
        y = ~freq,
        type = "bar",
        text = ~freq_rel_char,
        texttemplate = "%{text}",
        textposition = "outside",
        textfont = list(
            size = 20,
            color = "#41CBB8"
        ),
        color = ~level,
        colors = my_palette,
        hovertemplate = "<b>Frequency: %{y:,}</b><extra></extra>"
    )  %>%
    add_trace(
        data = df,
        x = ~level,
        y = ~freq_rel_cum,
        type = "scatter",
        mode = "lines+markers+text",
        marker = list(
            color = "#FF7000",
            size = 7
        ),
        line = list(
            color = "#E79340",
            width = 2
        ),
        text = ~freq_rel_cum_char,
        texttemplate = "%{text}",
        textposition = "bottom center",
        textfont = list(
            size = 20,
            color = "#FF7000"
        ),
        yaxis = "y2"
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
            title = "<b>Frequency</b>",
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            type = "linear",
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)",
            range = c(0, 1.1*max(df$freq))
        ),
        yaxis2 = list(
            range = c(0, 110),
            overlaying = "y",
            side = "right",
            title = "<b>Cumulative frequency</b>",
            titlefont = list(
                size = 20
            ),
            tickfont = list(
                size = 18
            ),
            type = "linear",
            color = "white",
            gridcolor = "rgba(0, 0, 0, 0)"
        ),
        margin = list(
            l = 10,
            r = 70,
            t = 10,
            b = 70
        ),
        hoverlabel = list(
            font = list(
                size = 16
            )
        ),
        showlegend = FALSE,
        plot_bgcolor = "rgba(0, 0, 0, 0)",
        paper_bgcolor = "rgba(0, 0, 0, 0)"
    )

    
}



