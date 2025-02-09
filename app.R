
#######################################################################################################################
############################################### Exoplanets Dashboard ##################################################
#######################################################################################################################

# Dev or prod mode (deploy):
app_dev = FALSE

# Paths:
path_funcs = "funcs/"
path_data = "data/"
path_style = "www/"
path_lib = "renv/library/R-4.1/x86_64-pc-linux-gnu/"

# Packages:
packages = c(
    "Amelia",
    "dplyr",
    "DT",
    "Hmisc",
    "moments",
    "plotly",
    "RColorBrewer",
    "reshape2",
    "rsconnect",
    "shiny",
    "shinycssloaders",
    "shinydashboard",
    "shinyWidgets",
    "stringr",
    "tidyr"
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
source(paste0(path_funcs, "plot_barplot.R"))
source(paste0(path_funcs, "plot_corrmatrix.R"))

# Global options:
options(spinner.color = "#0dc5c1")
options(spinner.type = 4)
sidebar_width = 250
set.seed(666)

# Theme:
color1 = "#282B33"
color2 = "#384875"
color3 = "#0B297B"

##################################################### Data ##########################################################

############# The Extrasolar Planets Encyclopaedia

# Read the data:
df_exoplant_eu = readRDS(paste0(path_data, "df_exoplanet_eu.rds"))
list_names_eu = readRDS(paste0(path_data, "list_names_eu.rds"))

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

# All variables
opts_exoplanet_eu_all_vars = unlist(unname(list_names_eu[names(df_exoplant_eu)]))

############# NASA Exoplanet Archive

# Read the data:
df_exoplant_nasa = readRDS(paste0(path_data, "df_exoplanet_nasa.rds"))
list_names_nasa = readRDS(paste0(path_data, "list_names_nasa.rds"))

### Options for the selects

# Numeric variables:
num_vars_nasa = df_exoplant_nasa %>%
                  dplyr::select_if(is.numeric) %>%
                  names()
list_opts_exoplanet_nasa_num_var = list_names_nasa[num_vars_nasa]
opts_exoplanet_nasa_num_var = unlist(unname(list_opts_exoplanet_nasa_num_var))

# Categoric variables with few levels and numeric variables:
nice_cat_var_nasa = df_exoplant_nasa %>%
                        dplyr::select_if(is.character) %>%
                        dplyr::select_if(has_few_levels) %>%
                        names()
list_opts_exoplanet_nasa_num_nicecat_var = list_names_nasa[c(num_vars_nasa, nice_cat_var_nasa)]
opts_exoplanet_nasa_color_var = unlist(unname(list_opts_exoplanet_nasa_num_nicecat_var))

# Categoric variables with few levels:
cat_var_nasa = df_exoplant_nasa %>%
                 dplyr::select_if(is.character) %>%
                 dplyr::select_if(has_few_levels) %>%
                 names()
cat_var_nasa = cat_var_nasa[which(!(cat_var_nasa %in% c("planet_status", "star_magnetic_field")))] # too few data
list_opts_exoplanet_nasa_cat_var = list_names_nasa[cat_var_nasa]
opts_exoplanet_nasa_cat_var = unlist(unname(list_opts_exoplanet_nasa_cat_var))

# All variables
opts_exoplanet_nasa_all_vars = unlist(unname(list_names_nasa[names(df_exoplant_nasa)]))


################################################### Backend ###########################################################

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
    
    observe({
        if(!is.null(input$exoplanet_eu_barplot_xvar)){
            # Chosen variable:
            x_var_name = input$exoplanet_eu_barplot_xvar
            x_var = list_opts_exoplanet_eu_cat_var[which(list_opts_exoplanet_eu_cat_var == x_var_name)] %>%
                        names()

            # Adapt the data:
            df_plot = df_exoplant_eu[, c(x_var)] %>%
                          as.data.frame() %>%
                          tidyr::drop_na()
            names(df_plot) = x_var
            df_plot = df_plot %>%
                          dplyr::group_by(eval(parse(text = x_var))) %>%
                          dplyr::summarise(freq = n()) %>%
                          as.data.frame() %>%
                          dplyr::arrange(desc(freq))
            names(df_plot)[1] = "level"

            # Levels order:
            df_plot$level = factor(x = df_plot$level,
                                   levels = unique(df_plot$level))
            
            # Relative frequency:
            df_plot$freq_rel = round(df_plot$freq/sum(df_plot$freq)*100,
                                     digits = 3)
            df_plot$freq_rel_char = paste0(df_plot$freq_rel, "%")
            
            # Cumulative frequency:
            df_plot$freq_rel_cum = cumsum(df_plot$freq_rel)
            df_plot$freq_rel_cum_char = paste0(df_plot$freq_rel_cum, "%")
            
            # Plot:
            output$exoplanet_eu_barplot_plot = renderPlotly({
                plot_barplot(df = df_plot,
                             x_var_name = x_var_name)
            })
        }
    })
    
    ### Correlation matrix
    
    observe({
        # Remove the columns with too little data:
        df_miss = missing_analysis(df_exoplant_eu) %>%
                      dplyr::filter(non_na_pct > 10)
        df_miss$var_name = as.character(df_miss$var_name)
        df_plot = df_exoplant_eu[, df_miss$var_name]
        
        # Take only the numeric columns:
        num_vars = df_plot %>%
                       dplyr::select_if(is.numeric) %>%
                       names()
        df_plot = df_plot[, num_vars]
        list_vars = list_names_eu[num_vars]
        names(df_plot) = unlist(unname(list_vars))

        # Correlation:
        df_plot = (df_plot %>%
                      as.matrix() %>%
                      Hmisc::rcorr(type = "pearson"))$r
        df_plot = reshape2::melt(data = df_plot,
                                 value.name = "Vars_corr")
        
        # Plot:
        output$exoplanet_eu_corrmatrix_plot = renderPlotly({
            plot_corrmatrix(df = df_plot)
        })
    })
    
    ### Table
    
    observe({
        if(!is.na(input$exoplanet_eu_table_vars[1])){
            df = df_exoplant_eu
            names(df) = opts_exoplanet_eu_all_vars
            table_vars = input$exoplanet_eu_table_vars
            df = df_exoplant_eu[, names(list_names_eu[which(list_names_eu %in% table_vars)])]
            df[is.na(df)] = "-"
            
            # Table:
            output$exoplanet_eu_table = DT::renderDataTable(
                df,
                options = list(
                    scrollX = TRUE,
                    columnDefs = list(
                        list(
                            className = "dt-center",
                            targets = "_all"
                        )
                    )
                ),
                rownames = FALSE,
                colnames = unlist(unname(list_names_eu[names(df)]))
            )
            
        }
    })
    
    ########################################## NASA Exoplanet Archive #################################################
    
    ### Missing Values
    
    output$exoplanet_nasa_missing_values_plot = renderPlotly({
        df_names = data.frame(
            "var_name" = names(list_names_nasa),
            "var_name_nice" = unlist(unname(list_names_nasa)),
            stringsAsFactors = FALSE
        )
        df_plot = missing_analysis(df_exoplant_nasa) %>%
                      dplyr::left_join(df_names,
                                       by = c("var_name" = "var_name"))
        plot_missing_values(df = df_plot)
    })
    
    ### Histogram
    
    observe({
        if(!is.null(input$exoplanet_nasa_histogram_xvar) &
           !is.null(input$exoplanet_nasa_histogram_bins)){
            # Chosen variable:
            x_var_name = input$exoplanet_nasa_histogram_xvar
            x_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == x_var_name)] %>%
                        names()

            # Dinamic range:
            xvals = df_exoplant_nasa[which(!is.na(df_exoplant_nasa[x_var])), x_var]
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
            output$ui_exoplanet_nasa_histogram_range = renderUI({
                sliderInput(
                    inputId = "exoplanet_nasa_histogram_range",
                    label = "",
                    min = xmin,
                    max = xmax,
                    step = xstep,
                    value = c(xmin, xmax),
                    width = "100%"
                )
            })
            
            # Plot:
            output$exoplanet_nasa_histogram_plot = renderPlotly({
                if(!is.null(input$exoplanet_nasa_histogram_range)){
                    x_min = input$exoplanet_nasa_histogram_range[1]
                    x_max = input$exoplanet_nasa_histogram_range[2]
                    df_plot = df_exoplant_nasa %>%
                                  dplyr::filter(eval(parse(text = x_var)) >= x_min &
                                                eval(parse(text = x_var)) <= x_max)
                    plot_histogram(df = df_plot,
                                   x_var = x_var,
                                   x_var_name = x_var_name,
                                   nbins = input$exoplanet_nasa_histogram_bins)
                }
            })
            
        }
    })
    
    ### 2D Density
    
    observe({
        if(!is.null(input$exoplanet_nasa_2d_density_xvar) &
           !is.null(input$exoplanet_nasa_2d_density_yvar) &
           !is.null(input$exoplanet_nasa_2d_density_xbins) &
           !is.null(input$exoplanet_nasa_2d_density_ybins)){
            # Chosen variables:
            x_var_name = input$exoplanet_nasa_2d_density_xvar
            x_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_nasa_2d_density_yvar
            y_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == y_var_name)] %>%
                        names()
            
            # Plot:
            output$exoplanet_nasa_2d_density_plot = renderPlotly({
                plot_2d_density(df = df_exoplant_nasa,
                                x_var = x_var,
                                y_var = y_var,
                                x_var_name = x_var_name,
                                y_var_name = y_var_name,
                                x_nbins = input$exoplanet_nasa_2d_density_xbins,
                                y_nbins = input$exoplanet_nasa_2d_density_ybins)
            })
        }
    })    

    ### Scatter with errors
    
    observe({
        if(!is.null(input$exoplanet_nasa_scatter_xvar) &
           !is.null(input$exoplanet_nasa_scatter_yvar)){
            # Chosen variables:
            x_var_name = input$exoplanet_nasa_scatter_xvar
            x_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_nasa_scatter_yvar
            y_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == y_var_name)] %>%
                        names()
            
            # Plot:
            output$exoplanet_nasa_scatter_plot = renderPlotly({
                plot_scatter(df = df_exoplant_nasa,
                             x_var = x_var,
                             y_var = y_var,
                             x_var_name = x_var_name,
                             y_var_name = y_var_name)
            })
        }
    })
    
    ### Bubble
    
    observe({
        if(!is.null(input$exoplanet_nasa_bubble_xvar) &
           !is.null(input$exoplanet_nasa_bubble_yvar) &
           !is.null(input$exoplanet_nasa_bubble_sizevar) &
           !is.null(input$exoplanet_nasa_bubble_colorvar)){
            # Chosen variables:
            x_var_name = input$exoplanet_nasa_bubble_xvar
            x_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_nasa_bubble_yvar
            y_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == y_var_name)] %>%
                        names()
            s_var_name = input$exoplanet_nasa_bubble_sizevar
            s_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == s_var_name)] %>%
                        names()
            c_var_name = input$exoplanet_nasa_bubble_colorvar
            c_var = list_opts_exoplanet_nasa_num_nicecat_var[which(list_opts_exoplanet_nasa_num_nicecat_var == c_var_name)] %>%
                        names()
            df_plot = df_exoplant_nasa[, c(x_var, y_var, s_var, c_var)] %>%
                          tidyr::drop_na()

            # Plot:
            output$exoplanet_nasa_bubble_plot = renderPlotly({
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
        if(!is.null(input$exoplanet_nasa_violin_xvar) &
           !is.null(input$exoplanet_nasa_violin_yvar) &
           !is.null(input$exoplanet_nasa_violin_scale)){
            # Chosen variables:
            x_var_name = input$exoplanet_nasa_violin_xvar
            x_var = list_opts_exoplanet_nasa_cat_var[which(list_opts_exoplanet_nasa_cat_var == x_var_name)] %>%
                        names()
            y_var_name = input$exoplanet_nasa_violin_yvar
            y_var = list_opts_exoplanet_nasa_num_var[which(list_opts_exoplanet_nasa_num_var == y_var_name)] %>%
                        names()
            df_plot = df_exoplant_nasa[, c(x_var, y_var)] %>%
                          tidyr::drop_na()

            # Levels order:
            sorted_levels = sort(unique(df_plot[, x_var]))
            df_plot[, x_var] = factor(x = df_plot[, x_var],
                                      levels = sorted_levels)
            
            # Plot:
            output$exoplanet_nasa_violin_plot = renderPlotly({
                plot_violin(df = df_plot,
                            x_var = x_var,
                            y_var = y_var,
                            x_var_name = x_var_name,
                            y_var_name = y_var_name,
                            plot_scale = input$exoplanet_nasa_violin_scale)
            })
        }
    })
    
    ### Barplot
    
    observe({
        if(!is.null(input$exoplanet_nasa_barplot_xvar)){
            # Chosen variable:
            x_var_name = input$exoplanet_nasa_barplot_xvar
            x_var = list_opts_exoplanet_nasa_cat_var[which(list_opts_exoplanet_nasa_cat_var == x_var_name)] %>%
                        names()

            # Adapt the data:
            df_plot = df_exoplant_nasa[, c(x_var)] %>%
                          as.data.frame() %>%
                          tidyr::drop_na()
            names(df_plot) = x_var
            df_plot = df_plot %>%
                          dplyr::group_by(eval(parse(text = x_var))) %>%
                          dplyr::summarise(freq = n()) %>%
                          as.data.frame() %>%
                          dplyr::arrange(desc(freq))
            names(df_plot)[1] = "level"

            # Levels order:
            df_plot$level = factor(x = df_plot$level,
                                   levels = unique(df_plot$level))
            
            # Relative frequency:
            df_plot$freq_rel = round(df_plot$freq/sum(df_plot$freq)*100,
                                     digits = 3)
            df_plot$freq_rel_char = paste0(df_plot$freq_rel, "%")
            
            # Cumulative frequency:
            df_plot$freq_rel_cum = cumsum(df_plot$freq_rel)
            df_plot$freq_rel_cum_char = paste0(df_plot$freq_rel_cum, "%")
            
            # Plot:
            output$exoplanet_nasa_barplot_plot = renderPlotly({
                plot_barplot(df = df_plot,
                             x_var_name = x_var_name)
            })
        }
    })
    
    ### Correlation matrix
    
    observe({
        # Remove the columns with too little data:
        df_miss = missing_analysis(df_exoplant_nasa) %>%
                      dplyr::filter(non_na_pct > 10)
        df_miss$var_name = as.character(df_miss$var_name)
        df_plot = df_exoplant_nasa[, df_miss$var_name]
        
        # Take only the numeric columns:
        num_vars = df_plot %>%
                       dplyr::select_if(is.numeric) %>%
                       names()
        df_plot = df_plot[, num_vars]
        list_vars = list_names_nasa[num_vars]
        names(df_plot) = unlist(unname(list_vars))

        # Correlation:
        df_plot = (df_plot %>%
                      as.matrix() %>%
                      Hmisc::rcorr(type = "pearson"))$r
        df_plot = reshape2::melt(data = df_plot,
                                 value.name = "Vars_corr")
        
        # Plot:
        output$exoplanet_nasa_corrmatrix_plot = renderPlotly({
            plot_corrmatrix(df = df_plot)
        })
    })
    
    ### Table
    
    observe({
        if(!is.na(input$exoplanet_nasa_table_vars[1])){
            df = df_exoplant_nasa
            names(df) = opts_exoplanet_nasa_all_vars
            table_vars = input$exoplanet_nasa_table_vars
            df = df_exoplant_nasa[, names(list_names_nasa[which(list_names_nasa %in% table_vars)])]
            df[is.na(df)] = "-"
            
            # Table:
            output$exoplanet_nasa_table = DT::renderDataTable(
                df,
                options = list(
                    scrollX = TRUE,
                    columnDefs = list(
                        list(
                            className = "dt-center",
                            targets = "_all"
                        )
                    )
                ),
                rownames = FALSE,
                colnames = unlist(unname(list_names_nasa[names(df)]))
            )
            
        }
    })
    
    
    
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
        
        ui_tab_exoplanet_eu(opts_num_var = opts_exoplanet_eu_num_var,
                            opts_color_var = opts_exoplanet_eu_color_var,
                            opts_cat_var = opts_exoplanet_eu_cat_var,
                            opts_all_vars = opts_exoplanet_eu_all_vars),

        ### NASA Exoplanet Archive
        
        ui_tab_exoplanet_nasa(opts_num_var = opts_exoplanet_nasa_num_var,
                              opts_color_var = opts_exoplanet_nasa_color_var,
                              opts_cat_var = opts_exoplanet_nasa_cat_var,
                              opts_all_vars = opts_exoplanet_nasa_all_vars)
        
        
    )
)

###################################################### Run ############################################################

shinyApp(ui = ui,
         server = server)

