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

    [k_nh4_ph_7],

    [k_nh4_ph_7_method],
 
    [total_carbon_ncs],

    [total_carbon_ncs_method],

    [total_nitrogen_ncs],

    [total_nitrogen_ncs_method],

    [organic_carbon_walkley_black],

    [oc_walkley_black_method],

    [ph_cacl2],

    [ph_cacl2_method],

    [ph_h2o],

    [ph_h2o_method],

    [phosphorus_bray1],

    [phosphorus_bray1_method],

    [phosphorus_bray2],

    [phosphorus_bray2_method],

    [phosphorus_mehlich_3],

    [phosphorus_mehlich_3_method],

    [base_sat_nh4oac_ph_7],

    [estimated_organic_carbon],

   [carbon_to_nitrogen_ratio],

    
              [texture_lab]

      ,[particle_size_method]

      ,[clay_total]

      ,[silt_total]

      ,[sand_total]
      
      ,[total_frag_wt_pct_gt_2_mm_ws]
    
      ,[bulk_density_oven_dry]

      ,[bulk_density_oven_dry_method]

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

                               'Acadia', 'ALAPAHA', 'Albany', 'Allanton', 'Angelina', 'Appling', 'ARKABUTLA', 'Arkana', 
							   'ARAWAK', 'Ashe', 'Ashlar', 'Attoyac', 'Bayboro', 'Bethera', 'Bonneau', 'Beauregard', 
							   'Benndale', 'Betis', 'Bibb', 'Bismarck', 'Blanton', 'Boulogne', 'Briley', 'Bude', 'Buncombe', 
							   'Burton', 'Bernaldo', 'Besner', 'Bienville', 'Bruno', 'Caddo', 'Cahaba', 'Carnasaw', 
							   'Caroline', 'Craven',  'Cataula', 'Cartecay', 'Cashiers', 'Cecil', 'CHENNEBY',
							   'Chandler', 'Chestnut', 'Chewacla','Clebit', 'Clarksville', 'Cleveland', 'Clifton',
							   'Cowarts', 'Cowee', 'Craggey', 'Congaree', 'Cullasaja',  'Davidson', 'Dillard', 'Dorovan', 
							   'Dothan', 'Dowling clay', 'Duplin', 'Edneyville', 'Enon', 'Escambia', 'Estate', 'Esto', 
							   'Evard', 'Evergreen', 'Fannin', 'French', 'Foxworth', 'Forestdale', 'Flomaton', 'Fuquay', 
							   'Glenmora', 'Goldsboro', 'Gore',  'Gullied', 'Guyton', 'Greenville', 'Gwinnett', 'Hard Labor',
							   'Haywood', 'Helena', 'Hemphill','Hiwassee', 'Harleston', 'Hurricane', 'Iotla', 'Jena',
							   'Kolin', 'Kingsferry', 'Kinston', 'Lakeland', 'Latonia', 'Leadvale', 'Leefield', 'Leon', 'Lily', 
							   'Louisburg', 'Lucy', 'Lenoir', 'Leon', 'Lloyd','IULUS', 'Lynchburg', 'Lexington', 'Maben', 
							   'Madison', 'Malbis', 'Mascotte', 'Mattex', 'McLaurin', 'Mecklenburg', 'Meggett', 'Moko', 'Mantachie', 
							   'Mollville', 'Nikwasi', 'Nixa', 'Noark', 'Norfolk', 'Nugent',  'Ocilla', 'Olustee', 'Orangeburg', 
							   'Ouachita', 'OCHLOCKONEE', 'Pacolet', 'Pamlico', 'Pantego', 'Pelham', 'Pirum', 'Plott', 'Plummer',
							   'Poarch', 'Ponzer', 'Porters', 'Portia', 'Pottsburg', 'Providence', 'Rains', 'Reddies', 'Rexor', 
							   'Rock outcrop', 'Rosman', 'Ruston', 'Rutlege','Saffell', 'Sapelo', 'Saucier', 'Sacul', 'Saunook', 
							   'Sharkey', 'Sunsweet', 'Swamp', 'Smithdale', 'Smithton', 'Starr', 'Susquehanna', 'Tate', 'Toccoa', 
							   'Toecane', 'Townley', 'Toxaway', 'Trimont', 'Troup', 'Tippah', 'Toinette', 'Tuckasegee', 'Tusquitee', 
							   'Trimont', 'Troup', 'Udorthents', 'Unaka', 'Urban land', 'Vance', 'Water', 'Wadley', 'Wagram', 
							   'Wahee', 'Waya', 'Wehadkee', 'Whiteside', 'Wickham', 'Wilkes', 'Woden', 'Wrightsville', 'Zafra'

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