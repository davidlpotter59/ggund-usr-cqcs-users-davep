description Claim Developement by Policy Year - SUMMARY Version;

include "startend.inc"
define unsigned ascii number l_policy_year[4]=year(lrssetup_combined:eff_date)

where 1 = 1
/*(((lrsdetail_combined:loss_paid <> 0 and
        (lrsdetail_combined:trans_date => l_starting_date and
         lrsdetail_combined:trans_date <= l_ending_date)) or

        (lrsdetail_combined:lae_paid <> 0 and
        (lrsdetail_combined:trans_date => l_starting_date and
         lrsdetail_combined:trans_date <= l_ending_date)) or

        ((lrsdetail_combined:loss_resv <> 0 and
         (lrssetup_combined:status <> "C") or
         (lrssetup_combined:status = "C" and
          lrssetup_combined:status_date => l_starting_date))) or

        ((lrsdetail_combined:lae_resv <> 0 and
         (lrssetup_combined:status <> "C") or
        (lrssetup_combined:status = "C" and
         lrssetup_combined:status_date => l_starting_date)))))
*/
and lrsdetail_combined:trans_code not one of 91,92,93,94,95,96,97,98,99

and lrsdetail_combined:trans_code < 30 
and lrsdetail_combined:trans_date => l_starting_date 
and lrsdetail_combined:trans_date <= l_ending_date 
--and lrssetup_combined:agent_no one of 111
--and year(lrssetup_combined:eff_date ) = 2007
and (lrsdetail_combined:loss_paid <> 0 or 
     lrsdetail_combined:loss_resv <> 0 or 
     lrsdetail_combined:lae_paid <> 0 )
and l_policy_year > 2001
and lrssetup_combined:line_of_business not one of 9

list
/title="Claim Developement by Policy Year - SUMMARY Version"
/nobanner
/domain="lrsdetail_combined"
/nodetail 
/noreporttotals 

claim_no /column=1
lrssetup_combined:policy_no/column=20 
lrssetup_combined:agent_no/heading="AGT" /column=35
lrssetup_combined:line_of_business/heading="LOB"/column=40
lrssetup_combined:eff_date /heading="Eff Date"/column=60
lrsdetail_combined:loss_resv/mask="(ZZZ,ZZZ,ZZZ.99)"/column=100 
lrsdetail_combined:loss_paid/mask="(ZZZ,ZZZ,ZZZ.99)" /column=120
lrsdetail_combined:lae_resv/mask="(ZZZ,ZZZ,ZZZ.99)" /column=140
lrsdetail_combined:lae_paid/mask="(ZZZ,ZZZ,ZZZ.99)"/column=160
""/heading="NET"/column=180

sorted by --l_policy_year
 lrsdetail_combined:claim_no--/newlines /total

/*top of l_policy_year 
""/newline 
l_policy_year/heading="Policy Year"/newline 
*/

/*
end of l_policy_year 
box/noheadings 
""/newline 
"Total for Policy Year"/column=20
l_policy_year/column=50/noheading 
total[lrsdetail_combined:loss_resv]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=lrsdetail_combined:loss_resv 
total[lrsdetail_combined:loss_paid]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail_combined:loss_paid 
total[lrsdetail_combined:lae_resv]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail_combined:lae_resv 
total[lrsdetail_combined:lae_paid]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=lrsdetail_combined:lae_paid 
total[lrsdetail_combined:loss_resv]+total[lrsdetail_combined:loss_paid]+total[lrsdetail_combined:lae_resv]+total[
lrsdetail_combined:lae_paid]/align=net 
xob 
*/

end of lrsdetail_combined:claim_no 
box/noheadings/noblanklines 
if total[lrsdetail_combined:loss_resv]+total[lrsdetail_combined:loss_paid]+total[lrsdetail_combined:lae_resv]+total[
lrsdetail_combined:lae_paid] => 500000 then 
{
claim_no /column=1
lrssetup_combined:policy_no/column=20 
lrssetup_combined:agent_no /column=35
lrssetup_combined:line_of_business /column=40
lrssetup_combined:eff_date /align=lrssetup_combined:eff_date 
total[lrsdetail_combined:loss_resv]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=lrsdetail_combined:loss_resv 
total[lrsdetail_combined:loss_paid]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail_combined:loss_paid 
total[lrsdetail_combined:lae_resv]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail_combined:lae_resv 
total[lrsdetail_combined:lae_paid]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=lrsdetail_combined:lae_paid 
total[lrsdetail_combined:loss_resv]+total[lrsdetail_combined:loss_paid]+total[lrsdetail_combined:lae_resv]+total[
lrsdetail_combined:lae_paid]/align=net 
}
xob 

top of page  
enquiryname                   /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/column=1/heading="Company Name   "/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading=
"Report Period  "/newline
