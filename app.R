
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
    "stringr",
    "moments"
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
source(paste0(path_funcs, "has_few_levels.R"))
source(paste0(path_funcs, "missing_analysis.R"))
source(paste0(path_funcs, "plot_missing_values.R"))
source(paste0(path_funcs, "plot_histogram.R"))
source(paste0(path_funcs, "plot_2d_density.R"))
source(paste0(path_funcs, "plot_scatter.R"))
source(paste0(path_funcs, "plot_bubble.R"))
source(paste0(path_funcs, "plot_violin.R"))

# Global options:
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

### Options for the selects

# Numeric variables:
num_vars_eu = df_exoplant_eu %>%
                  dplyr::select_if(is.numeric) %>%
                  names()
list_opts_exoplanet_eu_num_var = list_names_eu[num_vars_eu]
opts_exoplanet_eu_num_var = unlist(unname(list_opts_exoplanet_eu_num_var))

# Categoric variables with few levels and numeric variables:
nice_cat_var_eu = df_exoplant_eu %>%
                      dplyr::select_if(is.character) %>%
                      dplyr::select_if(has_few_levels) %>%
                      names()
list_opts_exoplanet_eu_num_nicecat_var = list_names_eu[c(num_vars_eu, nice_cat_var_eu)]
opts_exoplanet_eu_color_var = unlist(unname(list_opts_exoplanet_eu_num_nicecat_var))

# Categoric variables with few levels:
cat_var_eu = df_exoplant_eu %>%
                 dplyr::select_if(is.character) %>%
                 dplyr::select_if(has_few_levels) %>%
                 names()
cat_var_eu = cat_var_eu[which(!(cat_var_eu %in% c("planet_status", "star_magnetic_field")))] # too few data
list_opts_exoplanet_eu_cat_var = list_names_eu[cat_var_eu]
opts_exoplanet_eu_cat_var = unlist(unname(list_opts_exoplanet_eu_cat_var))

# Test:
# input = list()
# input$exoplanet_eu_histogram_xvar = "Planet mass (Jupiter mass)"
# input$exoplanet_eu_histogram_bins = 100
# input$exoplanet_eu_histogram_range = c(0, 135.3)
# input$exoplanet_eu_2d_density_xvar = "Planet mass (Jupiter mass)"
# input$exoplanet_eu_2d_density_yvar = "Planet radius (Jupiter radius)"
# input$exoplanet_eu_2d_density_xbins = 100
# input$exoplanet_eu_2d_density_ybins = 100
# input$exoplanet_eu_scatter_xvar = "Planet mass (Jupiter mass)"
# input$exoplanet_eu_scatter_yvar = "Planet radius (Jupiter radius)"
# input$exoplanet_eu_bubble_xvar = "Orbit semi-major axis (AU)"
# input$exoplanet_eu_bubble_yvar = "Orbit eccentricity"
# input$exoplanet_eu_bubble_sizevar = "Planet radius (Jupiter radius)"
# input$exoplanet_eu_bubble_colorvar = "Detection method"
# input$exoplanet_eu_violin_xvar = "Publication status"
# input$exoplanet_eu_violin_yvar = "Planet mass (Jupiter mass)"
# input$exoplanet_eu_violin_scale = "Linear"



################################################# Backend #########################################################

server = function(input, output, session){

    ##################################### Extrasolar Planets Encyclopaedia ############################################
    
    ### Missing Values
    
    output$exoplanet_eu_missing_values_plot = renderPlotly({
        df_names = data.frame(
            "var_name" = names(list_names_eu),
            "var_name_nice" = unlist(unname(list_names_eu)),
            stringsAsFactors = FALSE
        )
        df_plot = missing_analysis(df_exoplant_eu) %>%
                      dplyr::left_join(df_names,
                                       by = c("var_name" = "var_name"))
        plot_missing_values(df = df_plot)
    })
    
    ### Histogram
    
    observe({
        if(!is.null(input$exoplanet_eu_histogram_xvar) &
           !is.null(input$exoplanet_eu_histogram_bins)){
            # Chosen variable:
            x_var_name = input$exoplanet_eu_histogram_xvar
            x_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == x_var_name)] %>%
                        names()
            
            # Dinamic range:
            xvals = df_exoplant_eu[which(!is.na(df_exoplant_eu[x_var])), x_var]
            decdiff = xvals - trunc(xvals)
            decdiff_non_zero = decdiff[decdiff > 0]
            if(length(decdiff_non_zero) == 0){
                xmin = min(xvals)
                xmax = max(xvals)
                xstep = abs(xmax - xmin)/100
            } else{
                xmin = round(min(xvals),
                             digits = 2)
                xmax = round(max(xvals),
                             digits = 2)
                xstep = round(abs(xmax - xmin)/100,
                              digits = 2)
            }
            output$ui_exoplanet_eu_histogram_range = renderUI({
                sliderInput(
                    inputId = "exoplanet_eu_histogram_range",
                    label = "",
                    min = xmin,
                    max = xmax,
                    step = xstep,
                    value = c(xmin, xmax),
                    width = "100%"
                )
            })
            
            # Plot:
            output$exoplanet_eu_histogram_plot = renderPlotly({
                if(!is.null(input$exoplanet_eu_histogram_range)){
                    x_min = input$exoplanet_eu_histogram_range[1]
                    x_max = input$exoplanet_eu_histogram_range[2]
                    df_plot = df_exoplant_eu %>%
                                  dplyr::filter(eval(parse(text = x_var)) >= x_min &
                                                eval(parse(text = x_var)) <= x_max)
                    plot_histogram(df = df_plot,
                                   x_var = x_var,
                                   x_var_name = x_var_name,
                                   nbins = input$exoplanet_eu_histogram_bins)
                }
            })
            
        }
    })
    
    ### 2D Density
    
    observe({
        if(!is.null(input$exoplanet_eu_2d_density_xvar) &
           !is.null(input$exoplanet_eu_2d_density_yvar) &
           !is.null(input$exoplanet_eu_2d_density_xbins) &
           !is.null(input$exoplanet_eu_2d_density_ybins)){
            # Chosen variables:
            x_var_name = input$exoplanet_eu_2d_density_xvar
            x_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_eu_2d_density_yvar
            y_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == y_var_name)] %>%
                        names()
            
            # Plot:
            output$exoplanet_eu_2d_density_plot = renderPlotly({
                plot_2d_density(df = df_exoplant_eu,
                                x_var = x_var,
                                y_var = y_var,
                                x_var_name = x_var_name,
                                y_var_name = y_var_name,
                                x_nbins = input$exoplanet_eu_2d_density_xbins,
                                y_nbins = input$exoplanet_eu_2d_density_ybins)
            })
        }
    })    

    ### Scatter with errors
    
    observe({
        if(!is.null(input$exoplanet_eu_scatter_xvar) &
           !is.null(input$exoplanet_eu_scatter_yvar)){
            # Chosen variables:
            x_var_name = input$exoplanet_eu_scatter_xvar
            x_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_eu_scatter_yvar
            y_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == y_var_name)] %>%
                        names()
            
            # Plot:
            output$exoplanet_eu_scatter_plot = renderPlotly({
                plot_scatter(df = df_exoplant_eu,
                             x_var = x_var,
                             y_var = y_var,
                             x_var_name = x_var_name,
                             y_var_name = y_var_name)
            })
        }
    })
    
    ### Bubble
    
    observe({
        if(!is.null(input$exoplanet_eu_bubble_xvar) &
           !is.null(input$exoplanet_eu_bubble_yvar) &
           !is.null(input$exoplanet_eu_bubble_sizevar) &
           !is.null(input$exoplanet_eu_bubble_colorvar)){
            # Chosen variables:
            x_var_name = input$exoplanet_eu_bubble_xvar
            x_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_eu_bubble_yvar
            y_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == y_var_name)] %>%
                        names()
            s_var_name = input$exoplanet_eu_bubble_sizevar
            s_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == s_var_name)] %>%
                        names()
            c_var_name = input$exoplanet_eu_bubble_colorvar
            c_var = list_opts_exoplanet_eu_num_nicecat_var[which(list_opts_exoplanet_eu_num_nicecat_var == c_var_name)] %>%
                        names()
            df_plot = df_exoplant_eu[, c(x_var, y_var, s_var, c_var)] %>%
                          tidyr::drop_na()

            # Plot:
            output$exoplanet_eu_bubble_plot = renderPlotly({
                plot_bubble(df = df_plot,
                            x_var = x_var,
                            y_var = y_var,
                            s_var = s_var,
                            c_var = c_var,
                            x_var_name = x_var_name,
                            y_var_name = y_var_name,
                            s_var_name = s_var_name,
                            c_var_name = c_var_name)
            })
        }
    })
    
    ### Violin
    
    observe({
        if(!is.null(input$exoplanet_eu_violin_xvar) &
           !is.null(input$exoplanet_eu_violin_yvar) &
           !is.null(input$exoplanet_eu_violin_scale)){
            # Chosen variables:
            x_var_name = input$exoplanet_eu_violin_xvar
            x_var = list_opts_exoplanet_eu_cat_var[which(list_opts_exoplanet_eu_cat_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_eu_violin_yvar
            y_var = list_opts_exoplanet_eu_num_var[which(list_opts_exoplanet_eu_num_var == y_var_name)] %>%
                        names()
            df_plot = df_exoplant_eu[, c(x_var, y_var)] %>%
                          tidyr::drop_na()

            # Levels order:
            sorted_levels = sort(unique(df_plot[, x_var]))
            df_plot[, x_var] = factor(x = df_plot[, x_var],
                                      levels = sorted_levels)
            
            # Plot:
            output$exoplanet_eu_violin_plot = renderPlotly({
                plot_violin(df = df_plot,
                            x_var = x_var,
                            y_var = y_var,
                            x_var_name = x_var_name,
                            y_var_name = y_var_name,
                            plot_scale = input$exoplanet_eu_violin_scale)
            })
        }
    })
    
    
    
    
    
    
    ### Barplot

    ### Correlation matrix
    
    ### Table
    
    
    
    
    
    
    

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
        
        ui_tab_exoplanet_eu(opts_exoplanet_eu_num_var = opts_exoplanet_eu_num_var,
                            opts_exoplanet_eu_color_var = opts_exoplanet_eu_color_var,
                            opts_exoplanet_eu_cat_var = opts_exoplanet_eu_cat_var),

        ### NASA Exoplanet Archive
        
        ui_tab_exoplanet_nasa()
        
    )
)

###################################################### Run ############################################################

shinyApp(ui = ui,
         server = server)

