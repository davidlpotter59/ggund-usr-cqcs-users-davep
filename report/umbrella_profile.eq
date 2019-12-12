define wdate l_as_of_date = parameter/prompt="Enter As of Date"
define wdate l_starting_date = dateadd(l_as_of_date,0,-1)+1 
define wdate l_ending_date = l_as_of_date 

define signed ascii number l_new_renewal = if prsmaster:trans_code one of 10, 14 then prsmaster:premium else 0
define signed ascii number l_endorsement = if prsmaster:trans_code one of 12,13 then prsmaster:premium else 0
define signed ascii number l_cx = if prsmaster:trans_code one of 11 then prsmaster:premium else 0
define signed ascii number l_reinstate = if prsmaster:trans_code one of 16 then prsmaster:premium else 0
define signed ascii number l_audit = if prsmaster:trans_code one of 15 then prsmaster:premium else 0

define unsigned ascii number l_new_renew_ctr   = if l_new_renewal <> 0 then 1 else 0
define unsigned ascii number l_endorsement_ctr = if l_endorsement <> 0 then 1 else 1
define unsigned ascii number l_cx_ctr          = if l_cx <> 0 then 1 else 0
define unsigned ascii number l_reinstate_ctr   = if l_reinstate <> 0 then 1 else 0
define unsigned ascii number l_audit_ctr       = if l_audit <> 0 then 1 else 0

include "prscollect.inc"
and with prsmaster:trans_code < 17 
and with prsmaster:line_of_business = 07
and with sfsline:lob_code one of "ONE", "TWO","THREE","FOUR","FIVE"

list
/nobanner
/domain="prsmaster"
/title="Umbrella Profiles"
/nodetail 

prsmaster:policy_no 
--prsmaster:trans_code 
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:premium /total/mask="(ZZZ,ZZZ,ZZZ.99)"
l_new_renewal /total/mask="(ZZZ,ZZZ,ZZZ.99)" /heading="New-Renewal-Premium"
l_endorsement /total/mask="(ZZZ,ZZZ,ZZZ.99)" /heading="Endorsement-Premium"
l_cx /total/mask="(ZZZ,ZZZ,ZZZ.99)" /heading="Cancellation-Premium"
l_reinstate /total/mask="(ZZZ,ZZZ,ZZZ.99)" /heading="Reinstatement-Premium"
l_audit /total/mask="(ZZZ,ZZZ,ZZZ.99)"/heading="Audit-Premium"

l_new_renew_ctr /total/mask="ZZZZ"/heading="New-Renewal-Ctr"
l_endorsement_ctr  /total/mask="ZZZZ"/heading="Endorsement-Ctr"
l_cx_ctr  /total/mask="ZZZZ"/heading="Cancelation-Ctr"
l_reinstate_ctr  /total/mask="ZZZZ"/heading="Reinstatement-Ctr"
l_audit_ctr  /total/mask="ZZZZ"/heading="Audit-Ctr"

sorted by sfsline:description /newlines/total 
          prsmaster:policy_no 

end of prsmaster:policy_no
box/noheadings/noblanklines 
  prsmaster:policy_no 
  prsmaster:line_of_business 
  prsmaster:lob_subline 
  sfsline:description 
  total[prsmaster:premium]/align=prsmaster:premium /mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_new_renewal]/align=l_new_renewal /mask="(ZZZ,ZZZ,ZZZ.99)" 
  total[l_endorsement]/align=l_endorsement /mask="(ZZZ,ZZZ,ZZZ.99)" 
  total[l_cx]/align=l_cx/mask="(ZZZ,ZZZ,ZZZ.99)" 
  total[l_reinstate]/align=l_reinstate /mask="(ZZZ,ZZZ,ZZZ.99)" 
  total[l_audit]/align=l_audit /mask="(ZZZ,ZZZ,ZZZ.99)"

  l_new_renew_ctr/mask="ZZZZ"/align=l_new_renew_ctr 
  l_endorsement_ctr/align=l_endorsement_ctr /mask="ZZZZ"
  l_cx_ctr/align=l_cx_ctr /mask="ZZZZ"
  l_reinstate_ctr/align=l_reinstate_ctr /mask="ZZZZ"
  l_audit_ctr/align=l_audit_ctr /mask="ZZZZ"

end box

include "reporttop.inc"
/*
top of report 
l_starting_date /newline 
l_ending_date /newline 
*/
