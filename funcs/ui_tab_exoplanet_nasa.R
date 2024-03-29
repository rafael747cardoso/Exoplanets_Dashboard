
### UI of the NASA Exoplanet Archive tab

require(shinycssloaders)

ui_tab_exoplanet_nasa = function(opts_num_var, 
                                 opts_color_var,
                                 opts_cat_var,
                                 opts_all_vars){
    
    tabPanel(
        div(
            img(
                src = "logo_nasa_exoplanet_archive.jpeg",
                height = "50px",
                width = "120px",
                class = "tab-icon"
            ),
            div(
                class = "tab-name",
                "NASA Exoplanet Archive"
            )
        ),
        navbarPage(
            id = "navbar-exoplanet-nasa",
            title = "",
            position = "static-top",
            fluid = TRUE,
            
            ### Tab 1: Barplot of missing values
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Missing Values"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                fluidRow(
                                    column = 12,
                                    div(
                                        class = "card-no-border",
                                        div(
                                            class = "card-body",
                                            plotlyOutput(
                                                outputId = "exoplanet_nasa_missing_values_plot",
                                                height = "600px"
                                            ) %>%
                                                withSpinner(
                                                    size = 0.3,
                                                    proxy.height = "40px"
                                                )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            
            ### Tab 2: Histogram
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Histogram"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the x variable, the bins and the range:
                                fluidRow(
                                    # Variable:
                                    column(
                                        width = 4,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_histogram_xvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[14],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Bins:
                                    column(
                                        width = 4,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Bins"
                                            ),
                                            div(
                                                class = "card-body",
                                                sliderInput(
                                                    inputId = "exoplanet_nasa_histogram_bins",
                                                    label = "",
                                                    min = 10,
                                                    max = 1000,
                                                    step = 50,
                                                    value = 100,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Range:
                                    column(
                                        width = 4,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Range"
                                            ),
                                            div(
                                                class = "card-body",
                                                uiOutput(outputId = "ui_exoplanet_nasa_histogram_range")
                                            )
                                        )
                                    )
                                ),
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_histogram_plot",
                                                    height = "500px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            
            ### Tab 3: 2D Density
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "2D Density"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the variables and bins:
                                fluidRow(
                                    # Variable X:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable X"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_2d_density_xvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[51],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Variable Y:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable Y"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_2d_density_yvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[55],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Bins X:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Bins X"
                                            ),
                                            div(
                                                class = "card-body",
                                                sliderInput(
                                                    inputId = "exoplanet_nasa_2d_density_xbins",
                                                    label = "",
                                                    min = 10,
                                                    max = 1000,
                                                    step = 50,
                                                    value = 100,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Bins Y:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Bins Y"
                                            ),
                                            div(
                                                class = "card-body",
                                                sliderInput(
                                                    inputId = "exoplanet_nasa_2d_density_ybins",
                                                    label = "",
                                                    min = 10,
                                                    max = 1000,
                                                    step = 50,
                                                    value = 100,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    )
                                ),
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_2d_density_plot",
                                                    height = "500px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            
            ### Tab 4: Scatter with errors
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Scatter"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the variables X and Y:
                                fluidRow(
                                    # Variable X:
                                    column(
                                        width = 6,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable X"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_scatter_xvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[30],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Variable Y
                                    column(
                                        width = 6,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable Y"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_scatter_yvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[43],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    )
                                ),
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_scatter_plot",
                                                    height = "500px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            
            ### Tab 5: Bubble
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Bubble"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the variables X, Y, Size and Color:
                                fluidRow(
                                    # Variable X:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable X"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_bubble_xvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[30],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Variable Y:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable Y"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_bubble_yvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[22],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Variable Size:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Size"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_bubble_sizevar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[38],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Variable Color:
                                    column(
                                        width = 3,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Color"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_bubble_colorvar",
                                                    label = "",
                                                    choices = opts_color_var,
                                                    selected = opts_color_var[83],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    )
                                ),
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_bubble_plot",
                                                    height = "500px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),

            ### Tab 6: Violin
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Violin"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the variables:
                                fluidRow(
                                    # Variable X:
                                    column(
                                        width = 4,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable X"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_violin_xvar",
                                                    label = "",
                                                    choices = opts_cat_var,
                                                    selected = opts_cat_var[4],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Variable Y:
                                    column(
                                        width = 4,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable Y"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_violin_yvar",
                                                    label = "",
                                                    choices = opts_num_var,
                                                    selected = opts_num_var[14],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    ),
                                    # Scale:
                                    column(
                                        width = 4,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Scale"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_violin_scale",
                                                    label = "",
                                                    choices = c("Linear", "Log"),
                                                    selected = "Linear",
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )

                                        )
                                    )
                                ),
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_violin_plot",
                                                    height = "500px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            
            ### Tab 7: Barplot
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Barplot"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the variable:
                                fluidRow(
                                    # Variable X:
                                    column(
                                        width = 6,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variable X"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_barplot_xvar",
                                                    label = "",
                                                    choices = opts_cat_var,
                                                    selected = opts_cat_var[7],
                                                    multiple = FALSE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    )
                                ),
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_barplot_plot",
                                                    height = "500px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            
            ### Tab 8: Correlation matrix
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Correlation Matrix"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Plot:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                plotlyOutput(
                                                    outputId = "exoplanet_nasa_corrmatrix_plot",
                                                    height = "1000px"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),

            ### Tab 9: Table
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Table"
                ),
                fluidRow(
                    column(
                        width = 12,
                        div(
                            class = "card",
                            div(
                                class = "card-body",
                                # Choose the variables:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-header",
                                                "Variables"
                                            ),
                                            div(
                                                class = "card-body",
                                                selectInput(
                                                    inputId = "exoplanet_nasa_table_vars",
                                                    label = "",
                                                    choices = opts_all_vars,
                                                    selected = opts_all_vars[1:2],
                                                    multiple = TRUE,
                                                    width = "100%"
                                                )
                                            )
                                        )
                                    )
                                ),
                                # Table:
                                fluidRow(
                                    column(
                                        width = 12,
                                        div(
                                            class = "card-no-border",
                                            div(
                                                class = "card-body",
                                                DT::dataTableOutput(
                                                    outputId = "exoplanet_nasa_table"
                                                ) %>%
                                                    withSpinner(
                                                        size = 0.3,
                                                        proxy.height = "40px"
                                                    )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )

}

