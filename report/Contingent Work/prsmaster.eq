include "startend.inc"

define l_different_years = l_ending_date - l_starting_date 

define wdate l_starting_date1 = dateadd(l_starting_date,0,-1)
define wdate l_starting_date2 = dateadd(l_starting_date,0,-2)

define wdate l_ending_date1 = dateadd(l_ending_date,0,-1)
define wdate l_ending_date2 = dateadd(l_ending_date,0,-2)

define signed ascii number l_premium = if ((prsmaster:trans_date < l_starting_date and 
                                             prsmaster:trans_eff => l_starting_date and 
                                             prsmaster:trans_eff <= l_ending_date) or 
                                            (prsmaster:trans_date => l_starting_date and 
                                             prsmaster:trans_date <= l_ending_date and 
                                             prsmaster:trans_eff <= l_ending_date)) then prsmaster:premium else 0.00


define signed ascii number l_premium1 = if ((prsmaster:trans_date < l_starting_date1 and 
                                             prsmaster:trans_eff => l_starting_date1 and 
                                             prsmaster:trans_eff <= l_ending_date1) or 
                                            (prsmaster:trans_date => l_starting_date1 and 
                                             prsmaster:trans_date <= l_ending_date1 and 
                                             prsmaster:trans_eff <= l_ending_date1)) then prsmaster:premium else 0.00

define signed ascii number l_premium2 = if ((prsmaster:trans_date < l_starting_date2 and 
                                             prsmaster:trans_eff => l_starting_date2 and 
                                             prsmaster:trans_eff <= l_ending_date2) or 
                                            (prsmaster:trans_date => l_starting_date2 and 
                                             prsmaster:trans_date <= l_ending_date2 and 
                                             prsmaster:trans_eff <= l_ending_date2)) then prsmaster:premium else 0.00

define file sfslinea = access sfsline, set sfsline:company_id= prsmaster:company_id, 
                                           sfsline:line_OF_BUSINESS= prsmaster:line_of_business,
                                           sfsline:lob_subline= prsmaster:lob_subline 

define signed ascii number l_eligable_premium = if ((prsmaster:trans_date < l_starting_date and 
                                             prsmaster:trans_eff => l_starting_date and 
                                             prsmaster:trans_eff <= l_ending_date) or 
                                            (prsmaster:trans_date => l_starting_date and 
                                             prsmaster:trans_date <= l_ending_date and 
                                             prsmaster:trans_eff <= l_ending_date)) and 
                                             sfsline2:exclude_from_contingent = 0 then l_premium else 0.00

define signed ascii number l_eligable_premium1 = if ((prsmaster:trans_date < l_starting_date1 and 
                                             prsmaster:trans_eff => l_starting_date1 and 
                                             prsmaster:trans_eff <= l_ending_date1) or 
                                            (prsmaster:trans_date => l_starting_date1 and 
                                             prsmaster:trans_date <= l_ending_date1 and 
                                             prsmaster:trans_eff <= l_ending_date1)) and 
                                             sfsline2:exclude_from_contingent = 0 then l_premium1 else 0.00

define signed ascii number l_eligable_premium2 = if ((prsmaster:trans_date < l_starting_date2 and 
                                             prsmaster:trans_eff => l_starting_date2 and 
                                             prsmaster:trans_eff <= l_ending_date2) or 
                                            (prsmaster:trans_date => l_starting_date2 and 
                                             prsmaster:trans_date <= l_ending_date2 and 
                                             prsmaster:trans_eff <= l_ending_date2)) and 
                                             sfsline2:exclude_from_contingent = 0 then l_premium2 else 0.00
define signed ascii number l_not_eligable_premium = if ((prsmaster:trans_date < l_starting_date and 
                                             prsmaster:trans_eff => l_starting_date and 
                                             prsmaster:trans_eff <= l_ending_date) or 
                                            (prsmaster:trans_date => l_starting_date and 
                                             prsmaster:trans_date <= l_ending_date and 
                                             prsmaster:trans_eff <= l_ending_date)) and 
                                             sfsline2:exclude_from_contingent = 1 then l_premium else 0.00

define signed ascii number l_not_eligable_premium1 = if ((prsmaster:trans_date < l_starting_date1 and 
                                             prsmaster:trans_eff => l_starting_date1 and 
                                             prsmaster:trans_eff <= l_ending_date1) or 
                                            (prsmaster:trans_date => l_starting_date1 and 
                                             prsmaster:trans_date <= l_ending_date1 and 
                                             prsmaster:trans_eff <= l_ending_date1)) and 
                                             sfsline2:exclude_from_contingent = 1 then l_premium1 else 0.00

define signed ascii number l_not_eligable_premium2 = if ((prsmaster:trans_date < l_starting_date2 and 
                                             prsmaster:trans_eff => l_starting_date2 and 
                                             prsmaster:trans_eff <= l_ending_date2) or 
                                            (prsmaster:trans_date => l_starting_date2 and 
                                             prsmaster:trans_date <= l_ending_date2 and 
                                             prsmaster:trans_eff <= l_ending_date2)) and 
                                             sfsline2:exclude_from_contingent = 1 then l_premium2 else 0.00

include "prscollect.inc"
and with prsmaster:trans_code < 17
and prsmaster:comm_rate <> 0
--and sfslinea:stmt_lob not one of 999 
list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:agent_no 
l_premium /mask="(ZZZ,ZZZ,ZZZ.99)"/column=50/heading="Written-Premium"
l_eligable_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70/heading="Eligable-Premium"
l_not_eligable_premium/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90/heading="Ineligable-Premium"

l_premium1 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=110/heading="Written-Premium"
l_eligable_premium1/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130/heading="Eligable-Premium"
l_not_eligable_premium1/mask="(ZZZ,ZZZ,ZZZ.99)"/column=150/heading="Ineligable-Premium"

l_premium2 /mask="(ZZZ,ZZZ,ZZZ.99)"/column=170/heading="Written-Premium"
l_eligable_premium2/mask="(ZZZ,ZZZ,ZZZ.99)"/column=190/heading="Eligable-Premium"
l_not_eligable_premium2/mask="(ZZZ,ZZZ,ZZZ.99)"/column=210/heading="Ineligable-Premium"


sorted by sfsagent:agent_master_code/newlines 
          prsmaster:agent_no prsmaster:policy_no

top of sfsagent:agent_master_code 
box/noblanklines/noheadings
sfsagent:agent_master_code 
sfsagent:name[1]
xob

end of prsmaster:agent_no 
box/noblanklines/noheadings 
prsmaster:agent_no /column=15
total[l_premium]/column=50/mask="(ZZZ,ZZZ,ZZZ.99)"
total[l_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70
total[l_not_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90

total[l_premium1]/column=110/mask="(ZZZ,ZZZ,ZZZ.99)"
total[l_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
total[l_not_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=150

total[l_premium2]/column=170/mask="(ZZZ,ZZZ,ZZZ.99)"
total[l_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=190
total[l_not_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=210

xob

end of sfsagent:agent_master_code 
box/noblanklines/noheadings 
    "Total for Agent"
    total[l_premium]/column=50/mask="(ZZZ,ZZZ,ZZZ.99)"
    total[l_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70
    total[l_not_eligable_premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=90

    total[l_premium1]/column=110/mask="(ZZZ,ZZZ,ZZZ.99)"
    total[l_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=130
    total[l_not_eligable_premium1]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=150

    total[l_premium2]/column=170/mask="(ZZZ,ZZZ,ZZZ.99)"
    total[l_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=190
    total[l_not_eligable_premium2]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=210

xob

top of page 
str(year(l_ending_date))+ " Activity" /column=80
str(year(l_ending_date1)) + " Activity"/column=140
str(year(l_ending_date2)) + " Activity"/column=200
""/newline
