/*  Policy counts

    1.  As of date range
    2.  exclude anything where the policy expiration date < the as of date
    3.  group
        a.  new
        b.  renewal
        c.  cancellation
        d.  reinstate
*/

include "ending.inc"

define unsigned ascii number l_new = if prsmaster:trans_code one of 10 then 1 else 0
define unsigned ascii number l_cx  = if prsmaster:trans_code one of 11 then 1 else 0
define unsigned ascii number l_renew = if prsmaster:trans_code one of 14 then 1 else 0
define unsigned ascii number l_rein = if prsmaster:trans_code one of 16,17 then 1 else 0

where prsmaster:eff_date <= l_ending_date 
      and prsmaster:trans_exp => l_ending_date 
      and prsmaster:trans_code one of 10,11,14,16,17 -- new, cx, renewal, new rein, renewal rein

list
/nobanner
/domain="prsmaster"
/hold="policy_count"

sorted by prsmaster:policy_no 

end of prsmaster:policy_no 
--box/noblanklines/noheadings 
  prsmaster:policy_no /keyelement=1/name="policy_no"
  if ((total[l_new] + 
       total[l_renew] + 
       total[l_rein]) -
       total[l_cx]) > 0 then "ACTIVE" else "CANCEL"/name="status"
  prsmaster:line_of_business /name="lob"
  prsmaster:lob_subline/name="lob_subline"
  prsmaster:state/name="state"
  prsmaster:agent_no/name="agent"
--end box
