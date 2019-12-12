define file sfsline2a = access sfsline2, set sfsline2:company_id= contingent:company_id, 
                                             sfsline2:line_OF_BUSINESS= contingent:Line_of_business ,
                                             sfsline2:lob_subline= contingent:lob_subline 

define signed ascii number l_eligable_paid_commissions[9]=if sfsline2a:exclude_from_contingent not one of 1 then 
contingent:current_commission_paid else 0.00

where contingent:agent_no one of 153
--and sfsline2:exclude_from_contingent one of 0
 
list
/nobanner
/domain="contingent"

if contingent:current_incurred <> 0 or 
contingent:year2_incurred <> 0 or 
contingent:year3_incurred <> 0 or contingent:stop_loss <> 0 then 
{
contingent:agent_no 
contingent:line_of_business 
contingent:lob_subline 
contingent:stop_loss  
sfsline2:exclude_from_contingent /duplicates 
sfsline2a:exclude_from_contingent 
--l_eligable_paid_commissions /total 
--contingent:current_commission_paid /total 
/*
contingent:current_year_premium /total 
contingent:current_year_unearned /total  
contingent:current_commission_paid/total 

contingent:prior1_year_premium /total  
contingent:prior1_year_unearned  /total 
contingent:prior1_commission_paid/total 

contingent:prior2_year_premium  /total 
contingent:prior2_year_unearned /total 
contingent:prior2_commission_paid/total 
*/

contingent:current_incurred /total 
contingent:current_stop_loss /total 
contingent:stop_loss 
contingent:year2_incurred /total 
contingent:year3_incurred/total 
}

sorted by contingent:agent_no/newlines/total
 --         contingent:line_of_business /newlines/total 
 --         contingent:lob_subline
