
### UI of the NASA Exoplanet Archive tab

ui_tab_exoplanet_nasa = function(){
    
    tabPanel(
        div(
            img(
                src = "logo_nasa_exoplanet_archive.jpeg",
                height = "50px",
                width = "80px",
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
            
            ### Plot 1: Histogram
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Histogram"
                ),
                # Choose the x variable, the bins and the range:
                fluidRow(
                    
                    
                    
                ),
                # Plot:
                fluidRow(
                    
                )
                
                
            ),
            
            ### Plot 2: Bubble
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Bubble"
                ),
                # Choose x, y, color and size variables:
                fluidRow(
                    
                ),
                # Plot:
                fluidRow(
                    
                )
                
                
            ),

            ### Plot 3: Correlation matrix
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Correlation matrix"
                ),
                # Plot:
                fluidRow(
                    
                )
                
                
            ),
            
            ### Plot 4: 2D Histogram
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "2D Histogram"
                ),
                # Plot:
                fluidRow(
                    
                )
                
                
            ),
            
            ### Table
            
            tabPanel(
                div(
                    class = "sub-tab-name",
                    "Table"
                ),
                # Plot:
                fluidRow(
                    
                )
                
                
            )
            
            
            
        )
        
        
        
        
        
    )

}

