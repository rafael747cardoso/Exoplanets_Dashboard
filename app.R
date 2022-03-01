
#######################################################################################################################
############################################### Exoplanets Dashboard ##################################################
#######################################################################################################################

# Dev or prod mode (deploy)
app_dev = FALSE

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
# source(paste0(path_funcs, "func1.R"))

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
df_exoplant_eu = read.csv(file = paste0(path_data, "exoplanet_eu_catalog.csv"))

# NASA Exoplanet Archive:
df_exoplant_nasa = read.csv(file = paste0(path_data, "nasa_exoplanet_archive_PS_2022.02.27_15.16.00.csv"))




##################################################### Backend #########################################################

server = function(input, output, session){

    output$plot1 = renderPlotly(
        plot_ly(data = df_exoplant_eu,
                x = ~star_distance,
                y= ~mass)
    )
    
    output$plot2 = renderPlotly(
        plot_ly(data = df_exoplant_eu,
                x = ~orbital_period,
                y= ~semi_major_axis)
    )
        
    
}

#######################################################################################################################
##################################################### Frontend ########################################################

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

        ##################################### Extrasolar Planets Encyclopaedia ########################################

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

            fluidRow(
                column(
                    width = 12,
                    plotlyOutput("plot1")
                )
            )
        ),

        ######################################## NASA Exoplanet Archive ###############################################
        
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

            fluidRow(
                column(
                    width = 12,
                    plotlyOutput("plot2")
                )
            )
        )


    )
    
)


###################################################### Run ############################################################

shinyApp(ui = ui,
         server = server)

