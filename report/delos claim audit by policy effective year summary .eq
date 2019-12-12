include "startend.inc"
define unsigned ascii number l_policy_year[4]=year(lrssetup:eff_date)

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
and (lrsdetail:loss_paid <> 0 or 
     lrsdetail:loss_resv <> 0 or 
     lrsdetail:lae_paid <> 0 )
and l_policy_year > 2001
and lrssetup:line_of_business not one of 9

list
/nobanner
/domain="lrsdetail"
/nodetail 

claim_no /column=1
lrssetup:policy_no/column=20 
lrssetup:agent_no /column=35
lrssetup:line_of_business /column=40
lrsdetail:loss_resv/mask="(ZZZ,ZZZ,ZZZ.99)"/column=60 
lrsdetail:loss_paid/mask="(ZZZ,ZZZ,ZZZ.99)" /column=80
lrsdetail:lae_resv/mask="(ZZZ,ZZZ,ZZZ.99)" /column=100
lrsdetail:lae_paid/mask="(ZZZ,ZZZ,ZZZ.99)"/column=120
""/heading="NET"/column=140

sorted by l_policy_year
 --         lrsdetail:claim_no--/newlines /total

/*top of l_policy_year 
""/newline 
l_policy_year/heading="Policy Year"/newline 
*/

end of l_policy_year 
box/noheadings 
""/newline 
"Total for Policy Year"/column=20
l_policy_year/column=50/noheading 
total[lrsdetail:loss_resv]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=60 
total[lrsdetail:loss_paid]/mask="(ZZZ,ZZZ,ZZZ.99)" /column=80
total[lrsdetail:lae_resv]/mask="(ZZZ,ZZZ,ZZZ.99)" /column=100
total[lrsdetail:lae_paid]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=120
total[lrsdetail:loss_resv]+total[lrsdetail:loss_paid]+total[lrsdetail:lae_resv]+total[lrsdetail:lae_paid]/column=140
xob 

/*end of lrsdetail:claim_no 
box/noheadings/noblanklines 
claim_no /column=1
lrssetup:policy_no/column=20 
lrssetup:agent_no /column=35
lrssetup:line_of_business /column=40
total[lrsdetail:loss_resv]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=60 
total[lrsdetail:loss_paid]/mask="(ZZZ,ZZZ,ZZZ.99)" /column=80
total[lrsdetail:lae_resv]/mask="(ZZZ,ZZZ,ZZZ.99)" /column=100
total[lrsdetail:lae_paid]/mask="(ZZZ,ZZZ,ZZZ.99)"/column=120
total[lrsdetail:loss_resv]+total[lrsdetail:loss_paid]+total[lrsdetail:lae_resv]+total[lrsdetail:lae_paid]/column=140
xob 
*/

include "reporttop.inc"
