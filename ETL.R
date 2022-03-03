
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

# Functions:
# source(paste0(path_funcs, "func1.R"))

###### The Extrasolar Planets Encyclopaedia

df_exoplant_eu = read.csv(paste0(path_data, "exoplanet_eu_catalog.csv"))
names(df_exoplant_eu) = c(
    "planet_name",
    "planet_status",
    "planet_mass_juptmass",
    "planet_mass_juptmass_error_min",
    "planet_mass_juptmass_error_max",
    "planet_mass_sin_i_juptmass",
    "planet_mass_sin_i_juptmass_error_min",
    "planet_mass_sin_i_juptmass_error_max",
    "planet_radius_juptradius",
    "planet_radius_juptradius_error_min",
    "planet_radius_juptradius_error_max",
    "orbit_period_days",
    "orbit_period_days_error_min",
    "orbit_period_days_error_max",
    "orbit_semi_major_axis_au",
    "orbit_semi_major_axis_au_error_min",
    "orbit_semi_major_axis_au_error_max",
    "orbit_eccentricity",
    "orbit_eccentricity_error_min",
    "orbit_eccentricity_error_max",
    "orbit_inclination_deg",
    "orbit_inclination_deg_error_min",
    "orbit_inclination_deg_error_max",
    "angular_distance",
    "discovery_year",
    "last_update",
    "orbit_omega_deg",
    "orbit_omega_deg_error_min",
    "orbit_omega_deg_error_max",
    "orbit_t_peri_jd",
    "orbit_t_peri_jd_error_min",
    "orbit_t_peri_jd_error_max",
    "orbit_t_conj_jd",
    "orbit_t_conj_jd_error_min",
    "orbit_t_conj_jd_error_max",
    "orbit_t_zero_transit_jd",
    "orbit_t_zero_transit_jd_error_min",
    "orbit_t_zero_transit_jd_error_max",
    "orbit_t_zero_transit2_jd",
    "orbit_t_zero_transit2_jd_error_min",
    "orbit_t_zero_transit2_jd_error_max",
    "orbit_lambda_angle_deg",
    "orbit_lambda_angle_deg_error_min",
    "orbit_lambda_angle_deg_error_max",
    "orbit_impact_param_pct",
    "orbit_impact_param_pct_error_min",
    "orbit_impact_param_pct_error_max",
    "orbit_zero_radial_vel_time_jd",
    "orbit_zero_radial_vel_time_jd_error_min",
    "orbit_zero_radial_vel_time_jd_error_max",
    "orbit_vel_semiampl_m_per_s",
    "orbit_vel_semiampl_m_per_s_error_min",
    "orbit_vel_semiampl_m_per_s_error_max",
    "planet_calculated_temp_k",
    "planet_calculated_temp_k_error_min",
    "planet_calculated_temp_k_error_max",
    "planet_measured_temp_k",
    "planet_hot_point_lon_deg",
    "planet_geometric_albedo",
    "planet_geometric_albedo_error_min",
    "planet_geometric_albedo_error_max",
    "planet_log_g",
    "publication_status",
    "planet_detection_type",
    "planet_mass_detection_type",
    "planet_radius_detection_type",
    "planet_alternate_names",
    "planet_detected_molecules",
    "star_name",
    "star_ra_j2000_hh_mm_ss",
    "star_dec_j2000_hh_mm_ss",
    "star_mag_v",
    "star_mag_i",
    "star_mag_j",
    "star_mag_h",
    "star_mag_k",
    "star_distance_pc",
    "star_distance_pc_error_min",
    "star_distance_pc_error_max",
    "star_metallicity",
    "star_metallicity_error_min",
    "star_metallicity_error_max",
    "star_mass_sunmass",
    "star_mass_sunmass_error_min",
    "star_mass_sunmass_error_max",
    "star_radius_sunradius",
    "star_radius_sunradius_error_min",
    "star_radius_sunradius_error_max",
    "star_spectral_type",
    "star_age_giga_year",
    "star_age_giga_year_error_min",
    "star_age_giga_year_error_max",
    "star_teff_K",
    "star_teff_K_error_min",
    "star_teff_K_error_max",
    "star_detected_disc",
    "star_magnetic_field",
    "star_alternate_names"
)










saveRDS(object = df_exoplant_eu,
        file = paste0(path_data, "exoplanet_eu.rds"))

###### NASA Exoplanet Archive

df_exoplant_nasa = read.csv(paste0(path_data, "nasa_exoplanet_archive_PS_2022.02.27_15.16.00.csv"))











saveRDS(object = df_exoplant_nasa,
        file = paste0(path_data, "exoplanet_nasa.rds"))














