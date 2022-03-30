
#######################################################################################################################
############################################### Exoplanets Dashboard ##################################################
#######################################################################################################################

# Dev or prod mode (deploy):
app_dev = TRUE

# Paths:
path_funcs = "funcs/"
path_data = "data/"
path_style = "www/"
path_lib = "renv/library/R-4.1/x86_64-pc-linux-gnu/"

# Packages:
packages = c(
    "shiny",
    "shinydashboard",
    "shinyWidgets",
    "shinycssloaders",
    "dplyr",
    "plotly",
    "DT",
    "stringr"
)
if(app_dev == TRUE){
    for(pckg in packages){
        library(package = pckg,
                character.only = TRUE,
                lib.loc = path_lib)
    }
} else{
    for(pckg in packages){
        require(package = pckg,
                character.only = TRUE)
    }
}

# Functions:
source(paste0(path_funcs, "ui_tab_exoplanet_eu.R"))
source(paste0(path_funcs, "ui_tab_exoplanet_nasa.R"))

# Global options:
options(scipen = 999)
options(spinner.color = "#0dc5c1")
options(spinner.type = 4)
sidebar_width = 250
set.seed(666)

# Theme:
color1 = "#282B33"
color2 = "#384875"
color3 = "#0B297B"

##################################################### Data ############################################################

# The Extrasolar Planets Encyclopaedia:
df_exoplant_eu = readRDS(paste0(path_data, "df_exoplanet_eu.rds"))
list_names_eu = readRDS(paste0(path_data, "list_names_eu.rds"))

# NASA Exoplanet Archive:
df_exoplant_nasa = readRDS(paste0(path_data, "df_exoplanet_nasa.rds"))
list_names_nasa = readRDS(paste0(path_data, "list_names_nasa.rds"))

# Options for the selects:
num_vars_eu = df_exoplant_eu %>%
                  dplyr::select_if(is.numeric) %>%
                  names()
list_opts_exoplanet_eu_num_var = list_names_eu[num_vars_eu]
opts_exoplanet_eu_num_var = unlist(unname(list_opts_exoplanet_eu_num_var))




# test:
# input = list()
# input$exoplanet_eu_histogram_xvar = "Planet mass (Jupiter mass)"



##################################################### Backend #########################################################

server = function(input, output, session){

    ##################################### Extrasolar Planets Encyclopaedia ############################################
    
    ### Histrogram
    
    output$exoplanet_eu_histogram_plot = renderPlotly({
        if(!is.null(input$exoplanet_eu_histogram_xvar) &
           !is.null(input$exoplanet_eu_histogram_bins) &
           !is.null(input$exoplanet_eu_histogram_range)){
            
            x_var_name = input$exoplanet_eu_histogram_xvar
            x_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == x_var_name)] %>%
                        names()

            plot_ly(
                data = df_exoplant_eu,
                x = ~eval(parse(text = x_var)),
                type = "histogram",
                histfunc = "count",
                histnorm = "",
                nbinsx = 100,
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
    })
    
    
    

    ########################################## NASA Exoplanet Archive #################################################
    
    
    
    
    
    
    
}

#######################################################################################################################
##################################################### Front-end #######################################################

ui = fluidPage(
    
    # Theme:
    includeCSS(paste0(path_style, "styles.css")),

    # Head:
    tags$head(
        tags$link(rel = "shortcut icon",
                  type = "image/png",
                  href = "logo_exoplanets_browser_tab.png"),
        tags$title("Exoplanets")
    ),

    # Main menu:
    navbarPage(
        id = "navbar-main",
        title = div(
            img(
                src = "logo_exoplanets.png",
                height = "95px",
                width = "330px",
                class = "logo_bar"
            )
        ),
        position = "static-top",
        fluid = TRUE,

        ### Extrasolar Planets Encyclopaedia
        
        ui_tab_exoplanet_eu(
            opts_exoplanet_eu_num_var = opts_exoplanet_eu_num_var
        ),

        ### NASA Exoplanet Archive
        
        ui_tab_exoplanet_nasa()
        
    )
)

###################################################### Run ############################################################

shinyApp(ui = ui,
         server = server)

