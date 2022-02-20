
#######################################################################################################################
############################################### Exoplanets Dashboard ##################################################
#######################################################################################################################

# Paths:
path_funcs = "funcs/"
path_data = "data/"
path_style = "www/"
path_lib = "renv/library/R-4.1/x86_64-pc-linux-gnu/"

# Packages:
require(package = "shiny", lib.loc = path_lib)
require(package = "shinydashboard", lib.loc = path_lib)
require(package = "shinyWidgets", lib.loc = path_lib)
require(package = "shinycssloaders", lib.loc = path_lib)
require(package = "dplyr", lib.loc = path_lib)
require(package = "plotly", lib.loc = path_lib)
require(package = "DT", lib.loc = path_lib)
require(package = "stringr", lib.loc = path_lib)


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





##################################################### Backend #########################################################

server = function(input, output, session){

    
    
    
    
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
                  href = "logo_tab.png"),
        tags$title("Exoplanets")
    ),

    # Main menu:
    navbarPage(
        id = "navbar-main",
        title = div(
            img(
                src = "logo.png",
                height = "40px",
                width = "240px",
                class = "logo_bar"
            )
        ),
        position = "static-top",
        fluid = TRUE,

        ################################################# Page 1 ####################################################

        tabPanel(
            div(
                img(
                    src = "icon_1.png",
                    height = "50px",
                    width = "50px",
                    class = "tab-icon"
                ),
                div(
                    class = "tab-name",
                    "Page 1"
                )
            ),

            fluidRow(
                column(
                    width = 12,
                    "lelele"
                )
            )
        ),

        ################################################# Page 2 #####################################################
        
        tabPanel(
            div(
                img(
                    src = "icon_2.png",
                    height = "50px",
                    width = "50px",
                    class = "tab-icon"
                ),
                div(
                    class = "tab-name",
                    "Page 2"
                )
            ),

            fluidRow(
                column(
                    width = 12,
                    "lalala"
                )
            )
        )


    )
    
)


###################################################### Run ############################################################

shinyApp(ui = ui,
         server = server)

