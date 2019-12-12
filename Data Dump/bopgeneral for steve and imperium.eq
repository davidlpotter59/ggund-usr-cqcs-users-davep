
define file sfpname_alias = access sfpname,
                               set sfpname:policy_no    = bopgeneral:policy_no ,
                                   sfpname:pol_year     = bopgenerAL:POL_YEAR,
                                   sfpname:end_sequence = bopgeneral:end_sequence, exact 

define file sfpmaster_alias = access sfpmaster,
                                 set sfpmaster:policy_no    = bopgeneral:policy_no ,
                                     sfpmaster:pol_year     = bopgenerAL:POL_YEAR,
                                     sfpmaster:end_sequence = bopgeneral:end_sequence, exact 

define signed ascii number l_irpm_factor = if sfpmaster_alias:irpm <> 0 then
                                             sfpmaster_alias:irpm divide 100
define signed ascii number l_irpm_converted = if l_irpm_factor < 0 then
                                                 (-1 - l_irpm_factor) * -1
                                              else
                                                 1 + l_irpm_factor


list
/domain="bopgeneral"
/duplicate
--/maxrecords= 100

bopgeneral:policy_no policy_no pol_year end_sequence prem_no build_no state county line_of_business construction sprinklers protection territory 
bop_type tenant class_code sub_code rate_group rate_no building_limit building_premium building_special acv_building 
acv_building_premium acv_contents acv_contents_premium auto_percent auto_premium property_limit property_premium property_special 
property_rate adjustment_factors optional_total bop_premium signs_limit signs_premium signs_deductible[1] signs_not_attached_limit 
if sfpname_alias:eff_date >= 06.15.2011 then
  0.85
else  
  l_irpm_converted/heading="IRPM"
sfpname_alias:eff_date
bopgeneral:signs_not_attached_premium glass_limit glass_premium glass_deductible include_glass_deductible burglary_limit_on burglary_limit_off
 burglary_premium money_limit_on money_limit_off money_premium attach_bu5001 fire_limit fire_premium construction_year alarm_option[1] alarm_option[2] alarm_option[3]
 alarm_credit[1] alarm_credit[2] alarm_credit[3] alarm_factor loss_years location_credit wind_deductible loss_income_limit limit_loss_income loss_income_percent 
wholesaler delete_loss_income no_families ar_limit ar_premium utility_limit utility_premium building_code_limit 
building_code_percent building_code_premium customer_prop_limit customer_prop_premium mechanical_limit mechanical_premium 
pollution_limit pollution_premium valuable_papers_limit valuable_papers_premium single_occupancy boilers boilers_premium 
water_backup_limit water_backup_premium water_backup_limited water_backup_exclusion balis supplies_limit supplies_premium 
printers_errors printers_errors_credits other_structures percent_occupied reinsurance location_premium printers_error_premium 
wholesaler_percent loss_income_factor include_with_reinsurance burglar_alarm_system rating_territory rating_territory_factor 
rating_territory_sub_code rating_territory_group restaurant_enhancement receipts restaurant stories no_units apt_500_building 
apt_500_prop apt_500_total apt_500_fire apt_500_auto apt_500000 apt_difference apt_1000000 apt_500_expanded off_premises_limit 
off_premises_premium different_off_premises water_backup_fix charge_water_backup_fix remove_terrorism_form liability_only 
liability_premium apt_comm liability_charge territory_charge_credit condo key_risk fuel_pumps fuel_pump_charge  
adjustment_to_meet_minimum tier debris_removal_limit delete_loss_coverage weather_related windstorm_exclusion alarm_security 
special_exposure special_exposure_factor no_pools pool_premium special_enhancement credit_card_limit
