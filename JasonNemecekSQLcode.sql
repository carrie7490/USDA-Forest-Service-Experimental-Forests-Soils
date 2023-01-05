
SELECT

    l.[labsampnum],

    lcp.[result_source_key],

    lcp.[prep_code],

    cnn.[pedon_key],

    cnn.[site_key],

    p.[pedlabsampnum],

    [project_key],

    [layer_field_label_1],

    [hzn_top],

    [hzn_bot],

    CASE

        WHEN [hzn_top] < 100

            then [hzn_top]

        ELSE

            0

    END                                 AS InRangeTop_0_100,

    CASE

        WHEN [hzn_bot] <= 100

            THEN [hzn_bot]

        WHEN [hzn_bot] > 100

             and [hzn_top] < 100

            THEN 100

        ELSE

            0

    END                                 AS InRangeBot_0_100,

    [hzn_desgn],

    [pedoniid],

    [upedonid],

    CASE

        WHEN [corr_name] IS NULL

            THEN [samp_name]

        ELSE

            [corr_name]

    END                                 AS soil_name,

    CASE

        WHEN [corr_class_type] IS NULL

            THEN [samp_class_type]

        ELSE

            [corr_class_type]

    END                                 AS class_type,

    CASE

        WHEN [corr_classification_name] IS NULL

            THEN [samp_classification_name]

        ELSE

            [corr_classification_name]

    END                                 AS [classification_name],

    [siteiid],

    [usiteid],

    [site_obsdate],

    [latitude_decimal_degrees],

    [longitude_decimal_degrees],

    country_code,

    country_name,

    state_code,

    state_name,

    county_code,

    county_name,

    mlra_code,

    mlra_name,

    ssa_code,

    ssa_name,

    [note],

    [pedobjupdate], --    ,[siteobjupdate]

                    --   ,[prep_code]

                    --    ,[total_carbon_ncs]

                    --    ,[total_carbon_ncs_method]

                    --    ,[caco3_lt_2_mm]

                    --    ,[caco3_lt_2_mm_method]

                    --    ,[estimated_organic_carbon]

    CASE

        WHEN [estimated_organic_carbon] IS NOT NULL

            THEN LEFT(ROUND([estimated_organic_carbon] * 1.724, 2), 4)

        WHEN [estimated_organic_carbon] IS NULL

             AND [caco3_lt_2_mm] IS NOT NULL

            THEN LEFT(ROUND(([total_carbon_ncs] - ([caco3_lt_2_mm] * 0.12)) * 1.724, 2), 4)

        WHEN [estimated_organic_carbon] IS NULL

             AND [caco3_lt_2_mm] IS NULL

            THEN LEFT(ROUND([total_carbon_ncs] * 1.724, 2), 4)

    END                                 AS [estimated_organic_matter],

    (

        SELECT TOP 1

            [texture_lab]

        FROM

            [lab_physical_properties] AS lpp

        WHERE

            lpp.labsampnum = l.labsampnum

            AND [texture_lab] IS NOT NULL

    )                                   AS [lab_texture],

    [ca_nh4_ph_7],

    [ca_nh4_ph_7_method],

    [mg_nh4_ph_7],

    [mg_nh4_ph_7_method],

    [na_nh4_ph_7],

    [na_nh4_ph_7_method],

    [k_nh4_ph_7],

    [k_nh4_ph_7_method],

    [acidity_bacl2_tea_ph_8_2],

    [acidity_bacl2_tea_ph_82_method],

    [aluminum_kcl_extractable],

    [aluminum_kcl_extract_method],

    [manganese_kcl_extractable],

    [manganese_kcl_extract_method],

    [iron_kcl_extractable],

    [iron_kcl_extractable_method],

    [cec_nh4_ph_7],

    [cec_nh4_ph_7_method],

    [total_carbon_ncs],

    [total_carbon_ncs_method],

    [total_nitrogen_ncs],

    [total_nitrogen_ncs_method],

    [total_sulfur_ncs],

    [total_sulfur_ncs_method],

    [organic_carbon_walkley_black],

    [oc_walkley_black_method],

    [fe_dithionite_citrate_extract],

    [iron_dc_extract_method],

    [aluminum_dithionite_citrate],

    [aluminum_dc_extract_method],

    [manganese_dithionite_citrate],

    [manganese_dc_extract_method],

    [ammoniumoxalate_opticaldensity],

    [ammonium_ox_opt_dens_method],

    [fe_ammoniumoxalate_extractable],

    [iron_ammonium_oxalate_method],

    [aluminum_ammonium_oxalate],

    [al_ammonium_oxalate_method],

    [silica_ammonium_oxalate],

    [silica_ammonium_oxalate_method],

    [manganese_ammonium_oxalate],

    [mn_ammonium_oxalate_method],

    [carbon_sodium_pyro_phospate],

    [c_na_pyro_phosphate_method],

    [iron_sodium_pyro_phosphate],

    [iron_na_pyro_phosphate_method],

    [aluminum_na_pyro_phosphate],

    [aluminum_na_pyro_phosphate_met],

    [manganese_na_pyro_phosphate],

    [mn_na_pyro_phosphate_method],

    [ph_kcl],

    [ph_kcl_method],

    [ph_cacl2],

    [ph_cacl2_method],

    [ph_h2o],

    [ph_h2o_method],

    [ph_saturated_paste],

    [ph_saturated_paste_method],

    [ph_oxidized],

    [ph_oxidized_initial],

    [ph_oxidized_method],

    [ph_naf],

    [ph_naf_method],

    [ph_water_extract],

    [ph_water_extract_method],

    [caco3_lt_2_mm],

    [caco3_lt_2_mm_method],

    [corrected_gypsum_lt_2_mm],

    [corrected_gyp_lt_2_mm_method],

    [resistivity_saturated_paste],

    [resistivity_sp_method],

    [ca_satx],

    [ca_satx_method],

    [mg_satx],

    [mg_satx_method],

    [ca_plus_mg_satx],

    [ca_plus_mg_satx_method],

    [na_satx],

    [na_satx_method],

    [k_satx],

    [k_satx_method],

    [co3_satx],

    [co3_satx_method],

    [hco3_satx],

   [hco3_satx_method],

    [co3_plus_hco3_satx],

    [co3_plus_hco3_satx_method],

    [cl_satx],

    [cl_satx_method],

    [f_satx],

    [f_satx_method],

    [po4_satx],

    [po4_satx_method],

    [br_satx],

    [br_satx_method],

    [oac_satx],

    [oac_satx_method],

    [so4_satx],

    [so4_satx_method],

    [no2_satx],

    [no2_satx_method],

    [no3_satx],

    [no3_satx_method],

    [h20_satx],

    [h20_satx_method],

    [electrical_conductivity_satx],

    [electrical_cond_satx_method],

    [ec_predict_one_to_two],

    [ec_predict_one_to_two_method],

    [melanic_index],

    [melanic_index_method],

    [new_zealand_phosphorus_retent],

    [new_zealand_phos_retent_method],

    [phosphorus_ammonium_oxalate],

    [phosphorus_ammonium_oxalate_method],

    [phosphorus_anion_resin_one_hr],

    [phosphorus_anion_resin_24_hr],

    [phosphorus_anion_resin_method],

    [phosphorus_bray1],

    [phosphorus_bray1_method],

    [phosphorus_bray2],

    [phosphorus_bray2_method],

    [phosphorus_citric_acid],

    [phosphorus_citric_acid_method],

    [phosphorus_mehlich_3],

    [phosphorus_mehlich_3_method],

    [phosphorus_olsen],

    [phosphorus_olsen_method],

    [phosphorus_water],

    [phosphorus_water_method],

    [nitrate_1m_kcl],

    [nitrate_1m_kcl_method],

    [water_extract_method],

    [acetate_water_extractable],

    [aluminum_water_extractable],

    [arsenic_water_extractable],

    [barium_water_extractable],

    [boron_water_extractable],

    [bromide_water_extractable],

    [cadmium_water_extractable],

    [calcium_water_extractable],

    [chloride_water_extractable],

    [chromium_water_extractabe],

    [cobalt_water_extractable],

    [copper_water_extracable],

    [ec_water_extract],

    [fluoride_water_extractable],

    [iron_water_extractable],

    [lead_water_extractable],

    [magnesium_water_extractable],

    [manganese_water_extractable],

    [molybdenum_water_extractable],

    [nickel_water_extractable],

    [nitrate_n_water_extractable],

    [nitrate_water_extractable],

    [nitrite_water_extractable],

    [phosphorus_water_extractable],

    [phosphate_water_extractable],

    [potassium_water_extractable],

    [selenium_water_extractable],

    [silicon_water_extractable],

    [sodium_water_extractable],

    [strontium_water_extractable],

    [sulfate_water_extractable],

    [vanadium_water_extractable],

    [zinc_water_extractable],

    [mehlich_3_extractable_method],

    [aluminum_mehlich3_extractable],

    [arsenic_mehlich3_extractable],

    [barium_mehlich3_extractable],

    [cadmium_mehlich3_extractable],

    [calcium_mehlich3_extractable],

    [chromium_mehlich3_extractable],

    [cobalt_mehlich3_extractable],

    [copper_mehlich3_extractable],

    [iron_mehlich3_extractable],

    [lead_mehlich3_extractable],

    [magnesium_mehlich3_extractable],

    [manganese_mehlich3_extractable],

    [molybdenum_mehlich3_extractabl],

    [nickel_mehlich3_extractable],

    [phosphorus_mehlich3_extractable],

    [potassium_mehlich3_extractable],

    [selenium_mehlich3_extractable],

    [silicon_mehlich3_extractable],

    [sodium_mehlich3_extractable],

    [strontium_mehlich3_extractable],

    [zinc_mehlich3_extractable],

    [sum_of_nh4_ph_7_Ext_bases],

    [sum_of_cations_cec_pH_8_2],

    [ecec_base_plus_aluminum],

    [aluminum_saturation],

    [base_sat_sum_of_cations_ph_8_2],

    [base_sat_nh4oac_ph_7],

    [estimated_organic_carbon],

   [carbon_to_nitrogen_ratio],

    [aluminum_plus_half_iron_oxalat],

    [caco3_lt_20_mm],

    [gypsum_lt_20_mm],

    [ca_to_mg_ratio],

    [total_estimated_salts_satx],

    [exchangeable_sodium],

    [sodium_absorption_ratio],

    [phosphorus_anion_resin_capacit],

              [texture_lab]

      ,[particle_size_method]

      ,[clay_total]

      ,[silt_total]

      ,[sand_total]

      ,[clay_fine]

      ,[clay_caco3]

      ,[silt_fine]

      ,[silt_coarse]

      ,[sand_very_fine]

      ,[sand_fine]

      ,[sand_medium]

      ,[sand_coarse]

      ,[sand_very_coarse]

      ,[frag_2_5_mm_wt_pct_lt_75]

      ,[frag__2_20_mm_wt_pct_lt_75]

      ,[frag_5_20_mm_wt_pct_lt_75]

      ,[frag_20_75_mm_wt_pct_lt_75]

      ,[total_frag_wt_pct_gt_2_mm_ws]

      ,[wt_pct_1_tenth_to_75_mm]

      ,[bulk_density_tenth_bar]

      ,[bulk_density_tenth_bar_method]

      ,[bulk_density_third_bar]

      ,[bulk_density_third_bar_method]

      ,[bulk_density_oven_dry]

      ,[bulk_density_oven_dry_method]

      ,[bulk_density_lt_2_mm_air_dry]

      ,[bulk_density_air_dry_method]

      ,[bd_third_bar_lt2_reconstituted]

      ,[bd_thirdbar_reconstituted_method]

      ,[bulk_den_ovendry_reconstituted]

      ,[bulk_de_odreconstituted_method]

      ,[bulk_density_field_moist]

      ,[bulk_density_field_moist_metho]

      ,[particle_density_less_than_2mm]

      ,[particle_density_lt_2mm_method]

      ,[particle_density_gt_2_mm]

      ,[particle_density_gt_2mm_method]

      ,[cole_whole_soil]

      ,[cole_whole_soil_method]

      ,[le_third_fifteen_lt2_mm]

      ,[le_third_fifteen_lt2_metho]

      ,[le_third_ovendry_lt_2_mm]

      ,[le_third_ovendry_lt_2_mm_metho]

      ,[le_field_moist_to_oben_dry]

      ,[le_fm_to_od_method]

      ,[water_retention_0_bar_sieve]

      ,[water_retention_0_bar_method]

      ,[water_retention_6_hundredths]

      ,[water_retention_6_hund_method]

      ,[water_retention_10th_bar]

      ,[water_retention_10th_bar_meth]

      ,[water_retention_third_bar]

      ,[water_retention_thirdbar_metho]

      ,[water_retention_1_bar]

      ,[water_retention_1_bar_method]

      ,[water_retention_2_bar]

      ,[water_retention_2_bar_method]

      ,[water_retention_3_bar_sieve]

      ,[water_retention_3_bar_method]

      ,[water_retention_5_bar_sieve]

      ,[water_retention_5_bar_method]

      ,[water_retention_15_bar]

      ,[water_retention_15_bar_method]

      ,[water_retention_field_state]

      ,[water_retention_field_state_me]

      ,[airdry_ovendry_ratio]

      ,[atterberg_liquid_limit]

      ,[atterberg_liquid_limit_method]

      ,[atterberg_plasticity_index]

      ,[plastic_limit]

      ,[plastic_limit_method]

      ,[aggregate_stability_05_2_mm]

      ,[aggregate_stability_05_2_metho]

      ,[le_to_clay_third_bar_to_ovendr]

      ,[water_15_bar_to_clay_ratio]

      ,[cec7_clay_ratio]

      ,[effective_cec_to_clay_ratio]

      ,[psda_ethanol_dispersion_method]

     ,[sand_total_ethanol_dispersible]

      ,[silt_total_ethanol_dispersible]

      ,[clay_total_ethanol_dispersible]

      ,[sand_very_fine_ethanol_dispers]

      ,[sand_fine_ethanol_dispersible]

      ,[sand_medium_ethanol_dispersibl]

      ,[sand_coarse_ethanol_dispersibl]

      ,[sand_very_coarse_ethanol_disp]

      ,[water_dispersible_fraction_method]

      ,[clay_tot_h2o_dispersible]

      ,[clay_fine_h2o_dispersible]

      ,[clay_co3_h2o_dispersible]

      ,[silt_total_h2o_dispersible]

      ,[silt_fine_h2o_dispersible]

      ,[silt_coarse_h2o_dispersible]

      ,[sand_total_h2o_dispersible]

      ,[sand_vf_h2o_dispersible]

      ,[sand_fine_h2o_dispersible]

      ,[sand_medium_h2o_dispersible]

      ,[sand_coarse_h2o_dispersible]

      ,[sand_vc_h2o_dispersible]

      ,[color_pyrophosphate_extract]

      ,[color_pyrophosphate_method]

      ,[bd_thirdbar_before_rewet_organ]

      ,[bd_before_rewet_organic_method]

      ,[bd_thirdbar_rewet_organic_soil]

      ,[bd_third_rewet_organic_method]

      ,[bulk_den_rewet_oven_dry]

      ,[bulk_den_rewet_oven_dry_method]

      ,[mineral_content_loss_on_igniti]

      ,[mineral_content_loi_method]

      ,[estimated_organic_matter]

      ,[estimated_om_plus_mineral]

      ,[fiber_analysis_method]

      ,[fiber_unrubbed]

      ,[fiber_rubbed]

      ,[decomposition_state]

      ,[limnic_material_type]

FROM

    [lab_pedon]                   AS p

    INNER JOIN

        [lab_combine_nasis_ncss]  AS cnn

            ON p.pedon_key = cnn.pedon_key

               AND CASE

                       WHEN [corr_name] IS NULL

                           THEN [samp_name]

                       ELSE

                           [corr_name]

                   END IN (

                              'Wahee', 'Bayboro', 'Bethera', 'Bonneau', 'Caroline', 'Craven', 'Duplin', 'Goldsboro',

                              'Lenoir', 'Leon', 'Lynchburg', 'Meggett', 'Norfolk', 'Ocilla', 'Pantego', 'Rains',

                              'Water'

                          )

    INNER JOIN

        [lab_layer]               AS l

            ON l.pedon_key = p.pedon_key

               AND [hzn_top] < 100

    INNER JOIN

        [lab_chemical_properties] AS lcp

            ON lcp.labsampnum = l.labsampnum

       INNER JOIN

        [lab_physical_properties] AS lpp

            ON lpp.labsampnum = l.labsampnum

  

   INNER JOIN

        (

            SELECT

                [area_code] AS country_code,

                [area_name] AS country_name,

                area_key

            FROM

                lab_area -- Country

        )                         AS c

            ON cnn.[country_key] = c.area_key

    LEFT OUTER JOIN

        (

            SELECT

                [area_code] AS state_code,

                [area_name] AS state_name,

                area_key

            FROM

                lab_area --State

        )                         AS s

            ON cnn.[state_key] = s.area_key

    LEFT OUTER JOIN

        (

            SELECT

                [area_code] AS county_code,

                [area_name] AS county_name,

                area_key

            FROM

                lab_area --County

        )                         AS ct

            ON cnn.[county_key] = ct.area_key

    LEFT OUTER JOIN

        (

            SELECT

               [area_code] AS mlra_code,

                [area_name] AS mlra_name,

                area_key

            FROM

                lab_area --MLRA

        )                         AS m

            ON cnn.[mlra_key] = m.area_key

    LEFT OUTER JOIN

        (

            SELECT

                [area_code] AS ssa_code,

                [area_name] AS ssa_name,

                area_key

            FROM

                lab_area --SSA

        )                         AS ss

            ON cnn.[ssa_key] = ss.area_key