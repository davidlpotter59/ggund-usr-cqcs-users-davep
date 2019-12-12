/*  aggregate_rms.eq

    SCIPS.com, Inc.

    August 9th 2012

    Report for Aggregate RMS - location section
*/

description UPDATE - List, Aggregate Rms - Location section MUST be run AFTER Aggregate_Limit_Loc report  The 
Aggregate_Limit_Loc report runs and sets up the file used for Aggregate RMS report;



define string l_country = "USA"
define string l_occschem = "ATC"
define string l_bldgs    = "RMS"
define string l_num_stories = " "
define string l_lat = ""
define string l_long = ""
define string l_floorarea = ""
define string l_eq_limit = ""
define string l_eq_ded = ""
define unsigned number l_ws_limit = if aggregate_limit_loc:exclude_wind = "X" then 
1
else
aggregate_limit_loc:building_limit + aggregate_limit_loc:contents_limit + aggregate_limit_loc:ale_bi_limit

define number l_ws_ded =  if aggregate_limit_loc:exclude_wind = "X" then
1000
else if aggregate_limit_loc:hurricane_deductible <> 0 then
aggregate_limit_loc:hurricane_deductible
else
aggregate_limit_loc:building_deductable 

define string l_fl_limit = ""
define string l_fl_ded = ""

define unsigned number l_tr_limit = if aggregate_limit_loc:terrorism = "Y" then
aggregate_limit_loc:building_limit + aggregate_limit_loc:contents_limit + aggregate_limit_loc:ale_bi_limit
else
1

define unsigned number l_tr_ded = if aggregate_limit_loc:terrorism = "Y" then
aggregate_limit_loc:building_deductable 
else
1


--where aggregate_limit_loc:policy_no = 23059
where aggregate_limit_loc:trans_eff => 01.25.2016

list

/domain="aggregate_limit_loc"

aggregate_limit_loc:policy_no/heading="ACCNTNUM" 
aggregate_limit_loc:prem_no/heading="LOCNUM"
l_country/heading="CNTRYCO"
aggregate_limit_loc:address/heading="STREETNAME" 
aggregate_limit_loc:city/heading="CITY" 
aggregate_limit_loc:str_state/heading="STATECO" 
aggregate_limit_loc:zip_code/heading="POSTALCO"  
l_lat/heading="LATITUDE"
l_long/heading="LONGITUDE"
aggregate_limit_loc:building_limit/heading="FRCV1VA" 
aggregate_limit_loc:contents_limit/heading="FRCV2VA"
aggregate_limit_loc:ale_bi_limit/heading="FRCV3VA"
l_occschem/heading="OCCSCHEM"
aggregate_limit_loc:occupancycode /heading="OCCTY"
l_bldgs/heading="BLDGSCHEM"
aggregate_limit_loc:construction_code/heading="BLDGCLASS" 
aggregate_limit_loc:year_of_construction/heading="YEARBUILT"/mask="9999" 
aggregate_limit_loc:no_of_stories /heading="NUMSTORIES"
l_floorarea/heading="FLOORAREA"
l_eq_limit/heading="EQ LIMIT"
l_eq_ded/heading="EQ DEDUCTIBLE"
l_ws_limit/heading="WS LIMIT"
l_ws_ded/heading="WS DEDUCTIBLE"
l_fl_limit/heading="FL LIMIT"
l_fl_ded/heading="FL DEDUCTIBLE"
--aggregate_limit_loc:terrorism
l_tr_limit/heading="TR LIMIT"
--aggregate_limit_loc:building_deductable/heading="TR DEDUCTIBLE"
l_tr_ded/heading="TR DEDUCTIBLE"
