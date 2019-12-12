include "startend.inc"

include "prscollect.inc"

and with prsmaster:trans_code < 17

sum
/nobanner
/domain="prsmaster"
--/nodetail

prsmaster:premium/mask="(ZZZ,ZZZ,ZZZ.99)" 03

across prsmaster:trans_code
