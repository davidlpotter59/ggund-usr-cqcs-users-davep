include "startend.inc"

where 1 = 1
/*(((lrsdetail:loss_paid <> 0 and
        (lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date)) or

        (lrsdetail:lae_paid <> 0 and
        (lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date)) or

        ((lrsdetail:loss_resv <> 0 and
         (lrssetup:status <> "C") or
         (lrssetup:status = "C" and
          lrssetup:status_date => l_starting_date))) or

        ((lrsdetail:lae_resv <> 0 and
         (lrssetup:status <> "C") or
        (lrssetup:status = "C" and
         lrssetup:status_date => l_starting_date)))))
*/
and lrsdetail:trans_code not one of 91,92,93,94,95,96,97,98,99

and lrsdetail:trans_code < 30 
and lrsdetail:trans_date => l_starting_date 
and lrsdetail:trans_date <= l_ending_date 
--and lrssetup:agent_no one of 111
--and year(lrssetup:eff_date ) = 2007
--and lrssetup:claim_no one of 88813040047
and lrssetup:agent_no one of 173 
and sfsline2:exclude_from_contingent one of 1

list
/nobanner
/domain="lrsdetail"

lrsdetail:claim_no 
lrsdetail:preload 
lrssetup:policy_no 
lrssetup:agent_no 
lrsdetail:trans_code 
trans_date 
line_of_business 
sfsline:description 
lrsdetail:loss_resv/mask="(ZZZ,ZZZ,ZZZ.99)" 
loss_paid/mask="(ZZZ,ZZZ,ZZZ.99)" 
lae_resv/mask="(ZZZ,ZZZ,ZZZ.99)" 
lae_paid/mask="(ZZZ,ZZZ,ZZZ.99)"
sfsline2:exclude_from_contingent/duplicates  

lrssetup:status  lrssetup:status_date comments 

sorted by lrssetup:agent_no--/newlines 
          lrsdetail:claim_no/newlines /total
