-- include "startend.inc"

define wdate l_starting_date = 11.01.2018
define wdate l_ending_date   = todaysdate

define file sfsline_alias = access sfsline,
                               set sfsline:company_id       = "GGUND     ",
                                   sfsline:line_of_business = gsn_master:line_of_business,
                                   sfsline:lob_subline      = "00", exact 
 
define string l_sfs[3] = "SFS"

define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 
--define string l_company_id[10]="GGUND     "

define string l_company_id[10]=sfsdefaulta:company_id 
          
define string l_writing_company = "GSN"

define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= gsn_master:policy_no 
define file sfpnamea = access sfpname, set sfpname:policy_no= gsn_master:policy_no, 
                                           sfpname:pol_year= sfpcurrenta:pol_year, 
                                           sfpname:end_sequence= sfpcurrenta:end_sequence 

define file prsmastera = access prsmaster, set prsmaster:company_id = l_company_id, 
                                               prsmaster:policy_no  = gsn_master:policy_no, generic 

define file sfsagenta = access sfsagent, set sfsagent:company_id   = l_company_id, 
                                             sfsagent:agent_no     = sfpnamea:agent_no

define unsigned ascii number l_payment_plan = if prsmastera:trans_code < 17 and prsmastera:payment_plan <> 0 then prsmastera:payment_plan 
define string l_policy_type_indicator = if gsn_master:policy_eff_date < 01.01.2019 and 
   gsn_master:policy_indicator = "RENEWAL" then "NEW"
   else trun(gsn_master:policy_indicator)
define signed ascii number l_comm_to_gsn = (gsn_master:premium * (gsn_master:agency_commission * 0.01))
define string l_str_policy_no = (trun(sfsline_alias:alpha) + trun(str(gsn_master:policy_no)))
-- possible new for NARS define string l_str_policy_no = (trun(sfsline_alias:alpha) + trun(str(gsn_master:policy_no,"9(9)")))
define wdate l_accounting_date = if gsn_master:accounting_date <> l_ending_date then l_ending_date else gsn_master:accounting_date 

define string l_str_prior_pol_num = if val(gsn_master:policy_suffix) >= 1 then
    trun(sfsline_alias:alpha)+ trun(str(gsn_master:prior_policy_number)) else "0"

define wdate l_prior_eff_date = if val(gsn_master:policy_suffix) >= 1 then
    gsn_master:Prior_policy_Number_Eff_Date/heading="Prior_Policy_Number_Eff_Dt" else 01.01.1900

define file sfslinea = access sfsline, set sfsline:company_id    = l_company_id, 
                                           sfsline:line_of_business=  gsn_master:line_of_business,
                                           sfsline:lob_subline= "00"

define file sfslineab = access sfsline, set sfsline:company_id    = l_company_id, 
                                           sfsline:line_of_business=  gsn_master:line_of_business,
                                           sfsline:lob_subline= gsn_master:subline_code 

define file sfsline2a = access sfsline2, set sfsline2:company_id= sfslinea:company_id, 
                                             sfsline2:line_of_business= sfslinea:line_of_business, 
                                             sfsline2:lob_subline= gsn_master:subline_code  

define file sfsstmta = access sfsstmt, set sfsstmt:company_id= l_company_id, 
                                           sfsstmt:stmt_lob= sfslineab:stmt_lob

/* request from Rich Lemons on 02/2/2018  to add business description */
define file bopgenerala = access bopgeneral, set bopgeneral:policy_no = gsn_master:policy_no, generic 
define file cppgenerala = access cppgeneral, set cppgeneral:policy_no = gsn_master:policy_no, generic 
define file capvehivlea = access capvehicle, set capvehicle:policy_no = gsn_master:policy_no, generic 
define file scpdesca    = access scpdesc,    set scpdesc:policy_no    = gsn_master:policy_no, generic 
define string l_coverage_description = if gsn_master:line_of_business one of 5,50,51 then bopgenerala:business_desc[1]
else if gsn_master:line_of_business one of 2,8,11,13 then cppgenerala:business_desc[1]
else if gsn_master:line_of_business one of 7,15,16   then sfslinea:description 
else if gsn_master:line_of_business one of 6         then sfslineab:description 
else sfslineab:description 

where (gsn_master:premium <> 0 and  -- was 0
      ((gsn_master:trans_date < l_starting_date and 
       gsn_master:trans_eff_date => l_starting_date and 
       gsn_master:trans_eff_date <= l_ending_date) or
      (gsn_master:trans_date => l_starting_date and 
       gsn_master:trans_date <= l_ending_date and 
       gsn_master:trans_eff_date <= l_ending_date)) 
    and gsn_master:trans_eff_date => 11.20.2018
    and gsn_master:trans_date => 11.20.2018)

and sfslinea:line_of_business  one of 8

--and with policy_no one of 2300
--and with line_of_business one of 8
--and with lob_subline one of "81"

 --  and with policy_no one of 572

list 
/nobanner
/domain="gsn_master" 
--/csv="/www/gsn_master_for_nars"
--/csvseparator= "|"
/duplicates 
/nototals 
--/maxrecords=1000
--/xls=str(l_ending_date,"YYYYMMDD")+"_"+str(todaysdate,"YYYYMMDD")+"_GSN_MASTER"

-- change requested 01/05/2015
"G&G"/heading="Code"
/*
if accounting_date <> l_ending_date then
{  l_ending_date /heading="Bord_Date"/width=20/column=10
}
else
{
  accounting_date/col=10/noheading /width=25
}
*/
l_accounting_date /col=10/heading="BORD_DATE"/width=20

--(trun(sfsline_alias:alpha) + trun(str(gsn_master:policy_no)))/heading="Policy_Number"/
l_str_policy_no/column=35/width=15/heading="Str_Pol_NO"
gsn_master:policy_no /heading="Policy_No"/column=50
gsn_master:policy_eff_date/heading="Policy_Effective_Date"
gsn_master:policy_exp_date/heading="Policy_Expiration_Date"
-- change requested 01/05/2015
gsn_master:policy_exp_date/heading="Transaction_Expiration_Date"
gsn_master:trans_eff_date/heading="Transaction_Effective_Date"
gsn_master:lce_eff_date/heading="Loss_Cost_Effective_Date"

-- change requested 01/05/2015
/*if gsn_master:policy_eff_date < 01.25.2017 and 
   gsn_master:policy_indicator = "RENEWAL" then 
   {
     "NEW"/heading="Transaction_Type_Code"
   }
   else
   {
     trun(gsn_master:policy_indicator)
   }
*/

l_policy_type_indicator /heading="Transaction_Type_Code"
--trun(gsn_master:company_code)/heading="Writing_Company_Code"
trun(l_writing_company)+ "            "/heading="Writing_Company_Code"/width=30
trun(gsn_master:company_name)/heading="Writing_Company_Name"
trun(gsn_master:insured_name)/heading="Insured_Name" 
trun(gsn_master:insured_address)/heading="Insured_Mailing_Street1"
trun(gsn_master:insured_city)/heading="Insured_Mailing_City"
trun(gsn_master:insured_state)/heading="Insured_Mailing_State"
trun(gsn_master:insured_zip )/heading="Insured_Mailing_Zip"
trun(gsn_master:site_address)/heading="Risk_Location_Street1"
trun(gsn_master:site_city)/heading="Risk_Location_City"
trun(gsn_master:site_state)/heading="Risk_State"
trun(gsn_master:site_zip)/heading="Risk_Location_Zip"
trun(gsn_master:site_county)/heading="Risk_County"
trun(gsn_master:sic_code)/heading="SIC_Code"
trun(gsn_master:type_of_policy)/heading="Type_of_Policy"
trun(gsn_master:territory_code_iso)/heading="Territories_Code"
gsn_master:premium/heading="Premium"/total 
val(gsn_master:property_deductible)/mask="ZZZZZ9"/heading="Property Deductible"
gsn_master:limit[1]/heading="Limit 1"
gsn_master:limit[2]/heading="Limit 2" 
gsn_master:limit[3]/heading="Limit 3" 
gsn_master:limit[4]/heading="Limit 4" 
gsn_master:limit[5]/heading="Limit 5"
gsn_master:limit[6]/heading="Limit 6"
gsn_master:limit[7]/heading="Limit 7" 
gsn_master:limit[8]/heading="Limit 8"
gsn_master:limit[9]/heading="Limit 9"
gsn_master:limit[10]/heading="limit 10"
val(gsn_master:coverage_exposure)/mask="ZZZZZZZZ9"/heading="Exposure_Amount"
gsn_master:agency_commission/heading="Agency_Commission_Percent"  
sequence_number/heading ="Transaction_Sequence_Number" 
trun(annual_statement_lob[1,3])/heading ="ASLOB_Code" 
trun(ISO_subline_code)/heading="ISO_subline_code"
trun(isocoveragecode)/heading="ISO_Coverage_Code"
trun(terrorism_coverage_code)/heading ="Terrorism_Coverage_Code" 
trun(gsn_master:iso_class_code)/heading="ISO_Class_Code"
trun(stateexceptioncode)/heading ="ISO_State_Exception_Code"
trun(Limit_id)/heading="Limit_ID"
trun(ratingidcode)/heading="Rating_ID_Code" 
val(class_limit)/mask="ZZZZZ9"/heading="Class_Limit"
trun(rategroup)/heading="Rate_Group"
trun(ordinancelawid)/heading="Ordinance_Law_ID"
trun(protection_class_iso)/heading="Protection_Code"
trun(bceg)/heading="BCEG_Class_Code"
trun(construction_class)/heading="BGII_Construction_Code"
trun(form_code)/heading="Form_Code"
val(gsn_master:employees)/mask="ZZZZZ9"/heading="No_Of_Employees"
val(gsn_master:ratableemployees)/mask="ZZZZZ9"/heading="No_Of_Rateable_Employees"
val(gsn_master:premises)/mask="ZZZZZ9"/heading="No_Of_Premises"
trun(gsn_master:typeofequipmentcode)/heading="Type_Of_Equipment_Code"
trun(gsn_master:claims_made_policy_indicator)/heading="Claims_Made_Indicator"
trun(gsn_master:fac_indicator)/heading="FAC_Indicator"
trun(gsn_master:deductible_basis)/heading="Deductible_Basis"
val(gsn_master:co_insurance_factor)/mask="ZZZ9"/heading="Coinsurance_Percent"
gsn_master:pol_year/heading="Policy_Year"
gsn_master:attachment_point/heading="Attachment_Point"
gsn_master:prem_no/heading ="Location_No"
gsn_master:build_no/heading="Building_No"
gsn_master:line_of_business/heading="Line_of_Business"
gsn_master:sub_code/heading="Sub_Code"
trun(gsn_master:subline_code)/heading="SCIPS_Subline_Code"
gsn_master:limit[11]/heading="Limit 11"
gsn_master:limit[12]/heading="Limit 12" 
gsn_master:limit[13]/heading="Limit 13" 
gsn_master:limit[14]/heading="Limit 14" 
gsn_master:limit[15]/heading="Limit 15"
gsn_master:limit[16]/heading="Limit 16"
gsn_master:limit[17]/heading="Limit 17" 
gsn_master:limit[18]/heading="Limit 18"
gsn_master:limit[19]/heading="Limit 19"
gsn_master:limit[20]/heading="limit 20" 
gsn_master:limit[21]/heading="Limit 21"
gsn_master:limit[22]/heading="Limit 22" 
gsn_master:limit[23]/heading="Limit 23" 
gsn_master:limit[24]/heading="Limit 24" 
gsn_master:limit[25]/heading="Limit 25"
gsn_master:limit[26]/heading="Limit 26"
gsn_master:limit[27]/heading="Limit 27" 
gsn_master:limit[28]/heading="Limit 28"
gsn_master:limit[29]/heading="Limit 29"
gsn_master:limit[30]/heading="Limit 30"
gsn_master:wind_deductible/heading="Wind_Deductible"/mask="ZZZ9"
val(gsn_master:liability_deductible)/heading="Liability_Deductible"
gsn_master:deductible/heading="Deductible_Amount"
gsn_master:policy_suffix/heading ="Renewal_Indicator"
l_str_prior_pol_num /heading="Prior_Pol_Number" 
l_prior_eff_date /heading="Prior_Policy_Number_Eff_Dt"

/*
if val(gsn_master:policy_suffix) >= 1 then
  {
    trun(sfsline_alias:alpha)+ trun(str(gsn_master:prior_policy_number))/heading ="Prior_Pol_Number" 
    gsn_master:Prior_policy_Number_Eff_Date/heading="Prior_Policy_Number_Eff_Dt"
  }
else
  {  
    0
    01.01.1900/mask="mm/dd/yyyy"
  }
*/

gsn_master:payment_plan/heading="Pay_Plan"/width=15
--l_payment_plan/heading="Pay_Plan"/duplicates 
gsn_master:tsf/heading="Sur_Charge"/width=15
l_comm_to_gsn /heading="Comm_AMT"/mask="(ZZZ,ZZZ.99)"/width=15
--"NJ PLIGA"/heading="TSF_DESCRIPTION"
--sfslinea:stmt_lob/heading="STMT_LOB"
str(sfslinea:line_of_business) + trun(gsn_master:subline_code) /heading="GSN_STMT_LOB"
sfslineab:line_type 
--sfslineab:stmt_lob 
sfslineab:lob_code 
 
--sfslineab:description/heading="DESCRIPTION"
--sfsline2a:iso_stmt_lob
--sfsline2a:iso_subline 
--l_coverage_description /heading="Coverage Description"
--sfslineab:description /heading="Coverage Description"
sfslinea:description /heading="Policy Description"
sfslineab:description /heading="Coverage Description"


-- added 04/05/2019 per NARS
sfsagenta:name[1]/heading="Producer Name"
sfsagenta:address[1]/heading="Producer Address1"
sfsagenta:address[2]/heading="Producer Address2"
sfsagenta:city/heading="Producer City"
sfsagenta:str_state/heading="Producer State"
sfsagenta:str_zipcode/heading="Producer Zipcode"
sfsagenta:telephone[1]/heading="Producer Telephone"
sfsagenta:fax[1]/heading="Producer FAX"
sfsagenta:email_address/heading="Producer Email"


sorted by gsn_master:policy_no policy_no
