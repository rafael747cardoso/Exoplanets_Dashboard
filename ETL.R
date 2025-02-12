
#######################################################################################################################
############################################### Exoplanets ETL ########################################################
#######################################################################################################################

# Paths:
path_funcs = "funcs/"
path_data = "data/"
path_lib = "renv/library/R-4.1/x86_64-pc-linux-gnu/"

# Packages:
require(package = "dplyr", lib.loc = path_lib)
require(package = "plotly", lib.loc = path_lib)
require(package = "stringr", lib.loc = path_lib)
require(package = "Amelia", lib.loc = path_lib)
require(package = "RColorBrewer", lib.loc = path_lib)
require(package = "stringr", lib.loc = path_lib)

# Functions:
source(paste0(path_funcs, "missing_analysis.R"))
source(paste0(path_funcs, "empty_to_na.R"))


###################################### The Extrasolar Planets Encyclopaedia ###########################################

# Read the data:
df_exoplant_eu = read.csv(paste0(path_data, "dataset_exoplanet_eu_catalog.csv"))

# Column names:
list_names_eu = list(
    "planet_name" = "Planet name",
    "planet_status" = "Planet status",
    "planet_mass_juptmass" = "Planet mass (Jupiter mass)",
    "planet_mass_juptmass_error_min" = "Planet mass min error (Jupiter mass)",
    "planet_mass_juptmass_error_max" = "Planet mass max error (Jupiter mass)",
    "planet_mass_sin_i_juptmass" = "Planet mass*sin(i) (Jupiter mass)",
    "planet_mass_sin_i_juptmass_error_min" = "Planet mass*sin(i) min error(Jupiter mass)",
    "planet_mass_sin_i_juptmass_error_max" = "Planet mass*sin(i) max error (Jupiter mass)",
    "planet_radius_juptradius" = "Planet radius (Jupiter radius)",
    "planet_radius_juptradius_error_min" = "Planet radius min error (Jupiter radius)",
    "planet_radius_juptradius_error_max" = "Planet radius max error (Jupiter radius)",
    "orbit_period_days" = "Orbit period (days)",
    "orbit_period_days_error_min" = "Orbit period min error (days)",
    "orbit_period_days_error_max" = "Orbit period max error (days)",
    "orbit_semi_major_axis_au" = "Orbit semi-major axis (AU)",
    "orbit_semi_major_axis_au_error_min" = "Orbit semi-major axis min error (AU)",
    "orbit_semi_major_axis_au_error_max" = "Orbit semi-major axis max error (AU)",
    "orbit_eccentricity" = "Orbit eccentricity",
    "orbit_eccentricity_error_min" = "Orbit eccentricity min error",
    "orbit_eccentricity_error_max" = "Orbit eccentricity max error",
    "orbit_inclination_deg" = "Orbit inclination (deg)",
    "orbit_inclination_deg_error_min" = "Orbit inclination min error (deg)",
    "orbit_inclination_deg_error_max" = "Orbit inclination max error (deg)",
    "angular_distance" = "Angular distance (arcsec)",
    "discovery_year" = "Year of discovery",
    "last_update" = "Last update",
    "orbit_omega_deg" = "Argument of periastron (deg)",
    "orbit_omega_deg_error_min" = "Argument of periastron min error (deg)",
    "orbit_omega_deg_error_max" = "Argument of periastron max error (deg)",
    "orbit_t_peri_jd" = "Epoch of periastron (JD)",
    "orbit_t_peri_jd_error_min" = "Epoch of periastron min error (JD)",
    "orbit_t_peri_jd_error_max" = "Epoch of periastron max error (JD)",
    "orbit_t_conj_jd" = "Conjonction date (JD)",
    "orbit_t_conj_jd_error_min" = "Conjonction date min error (JD)",
    "orbit_t_conj_jd_error_max" = "Conjonction date max error (JD)",
    "orbit_t_zero_transit_jd" = "Primary transit (JD)",
    "orbit_t_zero_transit_jd_error_min" = "Primary transit min error (JD)",
    "orbit_t_zero_transit_jd_error_max" = "Primary transit max error (JD)",
    "orbit_t_zero_transit2_jd" = "Secondary transit (JD)",
    "orbit_t_zero_transit2_jd_error_min" = "Secondary transit min error (JD)",
    "orbit_t_zero_transit2_jd_error_max" = "Secondary transit max error (JD)",
    "orbit_lambda_angle_deg" = "Sky-projected angle between the planet orbital spin and the star spin (deg)",
    "orbit_lambda_angle_deg_error_min" = "Sky-projected angle between the planet orbital spin and the star spin min error (deg)",
    "orbit_lambda_angle_deg_error_max" = "Sky-projected angle between the planet orbital spin and the star spin max error (deg)",
    "orbit_impact_param_pct" = "Impact parameter b (%)",
    "orbit_impact_param_pct_error_min" = "Impact parameter b min error (%)",
    "orbit_impact_param_pct_error_max" = "Impact parameter b max error (%)",
    "orbit_zero_radial_vel_time_jd" = "Zero radial velocity time (JD)",
    "orbit_zero_radial_vel_time_jd_error_min" = "Zero radial velocity time min error (JD)",
    "orbit_zero_radial_vel_time_jd_error_max" = "Zero radial velocity time max error (JD)",
    "orbit_vel_semiampl_m_per_s" = "Velocity semiamplitude K (m/s)",
    "orbit_vel_semiampl_m_per_s_error_min" = "Velocity semiamplitude K min error (m/s)",
    "orbit_vel_semiampl_m_per_s_error_max" = "Velocity semiamplitude K max error (m/s)",
    "planet_calculated_temp_k" = "Calculated temperature (K)",
    "planet_calculated_temp_k_error_min" = "Calculated temperature min error (K)",
    "planet_calculated_temp_k_error_max" = "Calculated temperature max error (K)",
    "planet_measured_temp_k" = "Measured temperature (K)",
    "planet_hot_point_lon_deg" = "Hottest point longitude (deg)",
    "planet_geometric_albedo" = "Geometric albeto",
    "planet_geometric_albedo_error_min" = "Geometric albeto min error",
    "planet_geometric_albedo_error_max" = "Geometric albeto max error",
    "log_g" = "log(g)",
    "publication_status" = "Publication status",
    "planet_detection_type" = "Detection method",
    "planet_mass_detection_type" = "Mass measurement method",
    "planet_radius_detection_type" = "Radius measurement method",
    "planet_alternate_names" = "Planet alternate names",
    "planet_detected_molecules" = "List of detected molecules",
    "star_name" = "Name of the host star",
    "star_ra_j2000_hh_mm_ss" = "RA J2000 (hh:mm:ss)",
    "star_dec_j2000_hh_mm_ss" = "DEC J2000 (hh:mm:ss)",
    "star_mag_v" = "V magnitude of the host star",
    "star_mag_i" = "I magnitude of the host star",
    "star_mag_j" = "J magnitude of the host star",
    "star_mag_h" = "H magnitude of the host star",
    "star_mag_k" = "K magnitude of the host star",
    "star_distance_pc" = "Distance to the host star (pc)",
    "star_distance_pc_error_min" = "Distance to the host star min error (pc)",
    "star_distance_pc_error_max" = "Distance to the host star max error (pc)",
    "star_metallicity" = "Metallicity of the host star",
    "star_metallicity_error_min" = "Metallicity of the host star min error",
    "star_metallicity_error_max" = "Metallicity of the host star max error",
    "star_mass_sunmass" = "Mass of the host star (Sun mass)",
    "star_mass_sunmass_error_min" = "Mass of the host star min error (Sun mass)",
    "star_mass_sunmass_error_max" = "Mass of the host star max error (Sun mass)",
    "star_radius_sunradius" = "Radius of the host star (Sun radius)",
    "star_radius_sunradius_error_min" = "Radius of the host star min error (Sun radius)",
    "star_radius_sunradius_error_max" = "Radius of the host star max error (Sun radius)",
    "star_spectral_type" = "Spectral type of the host star",
    "star_age_giga_year" = "Age of the host star (Gy)",
    "star_age_giga_year_error_min" = "Age of the host star min error (Gy)",
    "star_age_giga_year_error_max" = "Age of the host star max error (Gy)",
    "star_teff_K" = "Effective temperature of the host star (K)",
    "star_teff_K_error_min" = "Effective temperature of the host star min error (K)",
    "star_teff_K_error_max" = "Effective temperature of the host star max error (K)",
    "star_detected_disc" = "Star detected disc",
    "star_magnetic_field" = "Star magnetic field",
    "star_alternate_names" = "List of star alternate names"
)

names(df_exoplant_eu) = names(list_names_eu)

# Change the empty strings for NA:
df_exoplant_eu = df_exoplant_eu %>%
                     dplyr::mutate_if(is.character, empty_to_na)

# Change the infinite values for NA:
df_exoplant_eu[df_exoplant_eu == Inf] = NA

# List all the detected molecules:
molecules = (df_exoplant_eu %>%
                dplyr::filter(!is.na(planet_detected_molecules)))$planet_detected_molecules %>%
                unique()
all_molecules = c()
for(i in 1:length(molecules)){
    molecules_i = molecules[i]
    molecules_i = str_split(string = molecules_i,
                            pattern = ", ")[[1]]
    all_molecules = c(all_molecules,
                      molecules_i)
}
all_molecules = unique(all_molecules) %>%
                    sort()
all_molecules_nice_names = str_replace_all(all_molecules,
                                           c(" " = "_",
                                             "\\+" = "_plus"))

# Make dummy variables for the molecules:
num_cols = ncol(df_exoplant_eu)
for(i in 1:length(all_molecules)){
    df_exoplant_eu[, num_cols + i] = ifelse(grepl(x = df_exoplant_eu$planet_detected_molecules,
                                                  pattern = all_molecules[i]),
                                            1,
                                            0)
    names(df_exoplant_eu)[num_cols + i] = paste0("planet_has_molecule_", all_molecules_nice_names[i])
}

# Update the names list:
for(i in 1:length(all_molecules)){
    list_names_eu[[num_cols + i]] = paste0("The planet has the molecule ", all_molecules[i])
    names(list_names_eu)[num_cols + i] = names(df_exoplant_eu)[num_cols + i]
}

# Save in RDS:
saveRDS(object = list_names_eu,
        file = paste0(path_data, "list_names_eu.rds"))
saveRDS(object = df_exoplant_eu,
        file = paste0(path_data, "df_exoplanet_eu.rds"))


############################################ NASA Exoplanet Archive ###################################################

# Read the data:
df_exoplant_nasa = read.csv(paste0(path_data, "dataset_nasa_exoplanet_archive_PS_2022.02.27_15.16.00.csv"))

# Make some categoric variables:
df_exoplant_nasa$star_num_stars_cat = as.character(df_exoplant_nasa$sy_snum)
df_exoplant_nasa$star_num_planets_cat = as.character(df_exoplant_nasa$sy_pnum)

# Column names:
list_names_nasa = list(
    "planet_name" = "Planet Name",
    "star_name" = "Host Star Name",
    "default_flag" = "Default Parameter Set",
    "star_num_stars" = "Number of Stars",
    "star_num_planets" = "Number of Planets",
    "discovery_method" = "Discovery Method",
    "disc_year" = "Discovery Year",
    "disc_facility" = "Discovery Facility",
    "solution_type" = "Solution Type",
    "planet_controversial_flag" = "Controversial Flag",
    "planet_refname" = "Planetary Parameter Reference",
    "planet_orb_period_days" = "Orbital Period (days)",
    "planet_orb_period_days_error_max" = "Orbital Period Upper Error (days)",
    "planet_orb_period_days_error_min" = "Orbital Period Lower Error (days)",
    "planet_orb_period_lim" = "Orbital Period Limit Flag",
    "planet_orb_semi_major_axis_max_au" = "Orbit Semi-Major Axis (AU)",
    "planet_orb_semi_major_axis_max_au_error_max" = "Orbit Semi-Major Axis Upper Error (AU)",
    "planet_orb_semi_major_axis_max_au_error_min" = "Orbit Semi-Major Axis Lower Error (AU)",
    "planet_orb_semi_major_axis_lim" = "Orbit Semi-Major Axis Limit Flag",
    "planet_radius_earth_radius" = "Planet Radius (Earth Radius)",
    "planet_radius_earth_radius_error_max" = "Planet Radius Upper Error (Earth Radius)",
    "planet_radius_earth_radius_error_min" = "Planet Radius Lower Error (Earth Radius)",
    "planet_radius_earth_radius_lim" = "Planet Radius Limit Flag",
    "planet_radius_jupiter_radius" = "Planet Radius (Jupiter Radius)",
    "planet_radius_jupiter_radius_error_max" = "Planet Radius Upper Error (Jupiter Radius)",
    "planet_radius_jupiter_radius_error_min" = "Planet Radius Lower Error (Jupiter Radius)",
    "planet_radius_jupiter_radius_lim" = "Planet Radius Limit Flag",
    "planet_mass_earth_mass" = "Planet Mass or Mass*sin(i) (Earth Mass)",
    "planet_mass_earth_mass_error_max" = "Planet Mass or Mass*sin(i) (Earth Mass) Upper Error",
    "planet_mass_earth_mass_error_min" = "Planet Mass or Mass*sin(i) (Earth Mass) Lower Error",
    "planet_mass_earth_mass_lim" = "Planet Mass or Mass*sin(i) (Earth Mass) Limit Flag",
    "planet_mass_jupiter_mass" = "Planet Mass or Mass*sin(i) (Jupiter Mass)",
    "planet_mass_jupiter_mass_error_max" = "Planet Mass or Mass*sin(i) (Jupiter Mass) Upper Error",
    "planet_mass_jupiter_mass_error_min" = "Planet Mass or Mass*sin(i) (Jupiter Mass) Lower Error",
    "planet_mass_jupiter_mass_lim" = "Planet Mass or Mass*sin(i) (Jupiter Mass) Limit Flag",
    "planet_mass_prov" = "Planet Mass or Mass*sin(i) Provenance",
    "planet_orb_eccentricity" = "Eccentricity",
    "planet_orb_eccentricity_error_max" = "Eccentricity Upper Error",
    "planet_orb_eccentricity_error_min" = "Eccentricity Lower Error",
    "planet_orb_eccentricity_lim" = "Eccentricity Limit Flag",
    "planet_insolation_flux_earth_flux" = "Insolation Flux (Earth Flux)",
    "planet_insolation_flux_earth_flux_error_max" = "Insolation Flux Upper Error (Earth Flux)",
    "planet_insolation_flux_earth_flux_error_min" = "Insolation Flux Lower Error (Earth Flux)",
    "planet_insolation_flux_earth_flux_lim" = "Insolation Flux Limit Flag",
    "planet_equilibrium_temperature_k" = "Equilibrium Temperature (K)",
    "planet_equilibrium_temperature_k_error_max" = "Equilibrium Temperature Upper Error (K)",
    "planet_equilibrium_temperature_k_error_min" = "Equilibrium Temperature Lower Error (K)",
    "planet_equilibrium_temperature_k_lim" = "Equilibrium Temperature Limit Flag",
    "transit_timing_variations_flag" = "Data show Transit Timing Variations",
    "star_refname" = "Stellar Parameter Reference",
    "star_spectral_type" = "Spectral Type",
    "star_effective_temperature_k" = "Stellar Effective Temperature (K)",
    "star_effective_temperature_k_error_max" = "Stellar Effective Temperature Upper Error (K)",
    "star_effective_temperature_k_error_min" = "Stellar Effective Temperature Lower Error (K)",
    "star_effective_temperature_k_lim" = "Stellar Effective Temperature Limit Flag",
    "star_radius_sun_radius" = "Stellar Radius (Solar Radius)",
    "star_radius_sun_radius_error_max" = "Stellar Radius Upper Error (Solar Radius)",
    "star_radius_sun_radius_error_min" = "Stellar Radius Lower Error (Solar Radius)",
    "star_radius_sun_radius_lim" = "Stellar Radius Limit Flag",
    "star_mass_sun_mass" = "Stellar Mass (Solar mass)",
    "star_mass_sun_mass_error_max" = "Stellar Mass Upper Error (Solar mass)",
    "star_mass_sun_mass_error_min" = "Stellar Mass Lower Error (Solar mass)",
    "star_mass_sun_mass_lim" = "Stellar Mass Limit Flag",
    "star_metallicity" = "Stellar Metallicity (dex)",
    "star_metallicity_error_max" = "Stellar Metallicity Upper Error (dex)",
    "star_metallicity_error_min" = "Stellar Metallicity Lower Error (dex)",
    "star_metallicity_lim" = "Stellar Metallicity Limit Flag",
    "star_metallicity_ratio" = "Stellar Metallicity Ratio",
    "star_log_g" = "Stellar Surface Gravity (log10(cm/s**2))",
    "star_log_g_error_max" = "Stellar Surface Gravity Upper Error (log10(cm/s**2))",
    "star_log_g_error_min" = "Stellar Surface Gravity Lower Error (log10(cm/s**2))",
    "star_log_g_lim" = "Stellar Surface Gravity Limit Flag",
    "system_refname" = "System Parameter Reference",
    "star_ra_j2000_hh_mm_ss" = "RA (sexagesimal)",
    "star_ra_j2000_deg" = "RA (deg)",
    "star_dec_j2000_hh_mm_ss" = "Dec (sexagesimal)",
    "star_dec_j2000_deg" = "Dec (deg)",
    "star_distance_pc" = "Distance (pc)",
    "star_distance_pc_error_max" = "Distance (pc) Upper Error",
    "star_distance_pc_error_min" = "Distance (pc) Lower Error",
    "star_v_mag" = "V (Johnson) Magnitude",
    "star_v_mag_error_max" = "V (Johnson) Magnitude Upper Error",
    "star_v_mag_error_min" = "V (Johnson) Magnitude Lower Error",
    "star_k_mag" = "Ks (2MASS) Magnitude",
    "star_k_mag_error_max" = "Ks (2MASS) Magnitude Upper Error",
    "star_k_mag_error_min" = "Ks (2MASS) Magnitude Lower Error",
    "star_gaia_mag" = "Gaia Magnitude",
    "star_gaia_mag_error_max" = "Gaia Magnitude Upper Error",
    "star_gaia_mag_error_min" = "Gaia Magnitude Lower Error",
    "row_update" = "Date of Last Update",
    "planet_publication_date" = "Planetary Parameter Reference Publication Date",
    "release_date" = "Release Date",
    "star_num_stars_cat" = "Number of Stars Categoric",
    "star_num_planets_cat" = "Number of Planets Categoric"
)
names(df_exoplant_nasa) = names(list_names_nasa)

# Change the empty strings for NA:
df_exoplant_nasa = df_exoplant_nasa %>%
                       dplyr::mutate_if(is.character, empty_to_na)

# Change the infinite values for NA:
df_exoplant_nasa[df_exoplant_nasa == Inf] = NA

# Remove extreme outliers:
df_exoplant_nasa = df_exoplant_nasa %>%
                       dplyr::filter(planet_orb_period_days < 1e6 &
                                     planet_radius_earth_radius < 1e2)

# Save in RDS:
saveRDS(object = list_names_nasa,
        file = paste0(path_data, "list_names_nasa.rds"))
saveRDS(object = df_exoplant_nasa,
        file = paste0(path_data, "df_exoplanet_nasa.rds"))






