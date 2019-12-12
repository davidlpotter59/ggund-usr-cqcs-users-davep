define file sfpname_alias = access sfpname,
                               set sfpname:policy_no    = bopgeneral:policy_no ,
                                   sfpname:pol_year     = bopgenerAL:POL_YEAR,
                                   sfpname:end_sequence = bopgeneral:end_sequence, exact 

define file sfpmaster_alias = access sfpmaster,
                                 set sfpmaster:policy_no    = bopgeneral:policy_no ,
                                     sfpmaster:pol_year     = bopgenerAL:POL_YEAR,
                                     sfpmaster:end_sequence = bopgeneral:end_sequence, exact 
                                                 

where cppgeneral:policy_no < 100000
list
/nobanner
/domain="cppgeneral"
/duplicates 
--/maxrecords=  1000

cppgeneral:policy_no pol_year end_sequence prem_no build_no
state county business_desc class_code sub_code protection form territory replacement_cost construction deductible coinsurance
group symbol inflation_guard sprinklered type builders_risk condo unit_owner theft vacancy sprinkler_leakage protective_systems 
agreed_value exclusions class_rate peril limit base_rate brtheft deductible_factor wind_deductible_factor earthquake_factor 
coinsurance_factor public_institute_factor sprinklered_rate fire_resistive_rate security_factor burglary_factor 
if sfpname_alias:eff_date >= 06.15.2011 and
   cppgeneral:company_deviation < 0.85 then
  0.85
else  
 cppgeneral:company_deviation[2]/heading="IRPM"

cppgeneral:water_exclusion_factor wind_exclusion_factor agreed_value_factor inflation_factor vacancy_factor debris_factor territory_factors 
territory_factor_2 net_factor package_mod adj_rate adj_premium premium package wind_deductible specific_rate_adjustment 
rate_eff_date group_no sub_group earthquake_rate_class rate_group cmp_symbol property_symbol trans_rate_no 
theft_territory_factor public_institutional sl_coinsurance total_premium residential construction_code property_class_code 
earthquake rating_territory_group rating_territory rating_territory_factor rating_territory_sub_code blanket apt_condo file_no 
contents_deductible contents_deduct_factor theft_adj_rate manually_rated new_rate rating_line_of_business description 
coinsurance_factor_b shopping_centers multiple_mercantiles mercantiles_with_apts schedule_rated other_subject_limit church 
specific_rate_minimum specific_minimum total_irpm blanket_description rate_survey_sent rate_survey_received adj_rate1 include_flood
 line_of_business protection_factor reinforced high steel crime_limit boilers boilers_premium loss_cost remove_terrorism_form 
total_endorsements total_misc community special_exposure_factor stories no_units multi_location_credit percent_of_values bceg 
bceg_individual symbol_number vmm_exclusion location_credit dont_inspect special_exposure res_condo
