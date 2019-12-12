
define file agqcontractora = access agqcontractor, set agqcontractor:app_no= agqname:app_no, generic 
define file agqvehiclea    = access agqvehicle, set agqvehicle:app_no= agqname:app_no, generic 
define file agqgenerala    = access agqgeneral, set agqgeneral:app_no=agqname:app_no, generic 

list
/nobanner
/domain="agqname"

--if agqcontractora:app_no = 0 and 
--   agqgenerala:app_no = 0 and 
--   agqvehiclea:app_no = 0 then 
{
agqname:app_no 
agqname:line_of_business 
agqcontractora:app_no /heading="contractors"
agqvehiclea:app_no /heading="vehicle"
agqgenerala:app_no/heading="general"
}
