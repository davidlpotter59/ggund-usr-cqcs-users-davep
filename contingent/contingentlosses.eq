define signed ascii number l_total_prior = contingentlosses:prior_reserve + contingentlosses:prior_loss_paid + contingentlosses:prior_lae_paid 
define signed ascii number l_total_current = contingentlosses:loss_reserve + loss_paid + lae_paid 

define signed ascii number l_stop_loss_calc =  if l_total_prior > contingentlosses:stop_loss then (l_total_current - l_total_prior)  
else if l_total_current > contingentlosses:stop_loss then (L_total_current - l_total_prior) - contingentlosses:stop_loss 
else if l_total_current < contingentlosses:stop_loss then 0

define file lrssetupa = access lrssetup_combined, set lrssetup_combined:company_id= contingentlosses:company_id, 
                                                      lrssetup_combined:claim_no= contingentlosses:claim_no 

--where contingentlosses:claim_no one of 1093401645, 1093403192, 44410100049
define file sfsline2a = access sfsline2, set sfsline2:company_id= contingentlosses:company_id, 
                                             sfsline2:line_of_business= lrssetupa:line_of_business, 
                                             sfsline2:lob_subline=      lrssetupa:lob_subline 

where contingentlosses:agent_no one of 100 -- 262, 276 ,153,128, 173
--and l_stop_loss_calc <> 0
--and sfsline2a:exclude_from_contingent not one of 1
--and (l_total_current => 300000 or l_total_prior => 300000)
--and contingentlosses:amount_over_stop_loss <> 0

list
/nobanner
/domain="contingentlosses"

contingentlosses:company_id 
contingentlosses:agent_no 
contingentlosses:claim_no 
contingentlosses:accounting_date 
-- sfsline2a:exclude_from_contingent 

contingentlosses:loss_reserve 
--contingentlosses:prior_reserve 
--contingentlosses:lae_reserve 
contingentlosses:loss_paid 
contingentlosses:lae_paid 
--contingentlosses:recovery 

contingentlosses:loss_reserve 
+ contingentlosses:loss_paid 
+ contingentlosses:lae_paid 
+ contingentlosses:recovery /heading="Total Incurred"

if contingentlosses:loss_reserve 
+ contingentlosses:loss_paid 
+ contingentlosses:lae_paid 
+ contingentlosses:recovery > 300000 then 
{
  (contingentlosses:loss_reserve 
+ contingentlosses:loss_paid 
+ contingentlosses:lae_paid 
+ contingentlosses:recovery) - 300000/heading="Stop Loss-Amount"/mask="(ZZZ,ZZZ,ZZZ.99)"
}
else
{
0.00/mask="(ZZZ,ZZZ,ZZZ.99)"

}

/*contingentlosses:stop_loss 
--contingentlosses:amount_over_stop_loss 
l_total_prior/heading="Prior ITD-Incurred-2010" 
l_total_current/heading="Current ITD-Incurred-2011" 
l_total_current -l_total_prior /heading="Current Year-Difference"
--l_stop_loss_calc/heading="Stop Loss-Adjustment"
contingentlosses:amount_over_stop_loss/heading="Stop Loss-Adjustment" /total
*/
