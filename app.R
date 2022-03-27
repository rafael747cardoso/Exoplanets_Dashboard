
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

# NASA Exoplanet Archive:
df_exoplant_nasa = readRDS(paste0(path_data, "df_exoplanet_nasa.rds"))



##################################################### Backend #########################################################

server = function(input, output, session){

    ##################################### Extrasolar Planets Encyclopaedia ############################################
    
    
    
    
    

    ########################################## NASA Exoplanet Archive #################################################
    
    
    
    
    
    
    
}

#######################################################################################################################
##################################################### Front-end #######################################################

ui = fluidPage(
    
    # Theme:
    includeCSS(paste0(path_style, "styles.css")),
    shinyWidgets::setBackgroundColor(
        color = c(color1, color2),
        gradient = "linear",
        direction = "right"
    ),

    # Head:
    tags$head(
        tags$link(rel = "shortcut icon",
                  type = "image/png",
                  href = "logo_exoplanets.png"),
        tags$title("Exoplanets")
    ),

    # Main menu:
    navbarPage(
        id = "navbar-main",
        title = div(
            img(
                src = "logo_exoplanets.png",
                height = "95px",
                width = "350px",
                class = "logo_bar"
            )
        ),
        position = "static-top",
        fluid = TRUE,

        ### Extrasolar Planets Encyclopaedia
        
        ui_tab_exoplanet_eu(),

        ### NASA Exoplanet Archive
        
        ui_tab_exoplanet_nasa()
        
    )
)

###################################################### Run ############################################################

shinyApp(ui = ui,
         server = server)

