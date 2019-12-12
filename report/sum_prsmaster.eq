include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17

sum
/nobanner
/domain="prsmaster"

prsmaster:premium 

across prsmaster:trans_code 

by prsmaster:state
