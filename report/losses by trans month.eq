
include  "startend.inc"
define string l_prog_number = "Reserves by Month"

/*define signed ascii number l_jan_resv = if month(lrsdetail:trans_date) = 1 then lrsdetail:loss_resv else 0
define signed ascii number l_feb_resv = if month(lrsdetail:trans_date) = 2 then lrsdetail:loss_resv else 0
define signed ascii number l_mar_resv = if month(lrsdetail:trans_date) = 3 then lrsdetail:loss_resv else 0
define signed ascii number l_apr_resv = if month(lrsdetail:trans_date) = 4 then lrsdetail:loss_resv else 0
*/

where lrsdetail:trans_date => l_starting_date and 
      lrsdetail:trans_date <= l_ending_date 
and lrsdetail:trans_code < 20

sum
/nobanner
/domain="lrsdetail"
/title= "Reserves by Month"

lrsdetail:loss_resv /total 
across month(lrsdetail:trans_date)

by lrsdetail:claim_no

--include "reporttop.inc"
