
### UI of the Extrasolar Planets Encyclopaedia tab

ui_tab_exoplanet_eu = function(){
    
    tabPanel(
        div(
            img(
                src = "logo_exoplanet_eu.png",
                height = "50px",
                width = "120px",
                class = "tab-icon"
            ),
            div(
                class = "tab-name",
                "Extrasolar Planets Encyclopaedia"
            )
        ),
        navbarPage(
            id = "navbar-exoplanet-eu",
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

