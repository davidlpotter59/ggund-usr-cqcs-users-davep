include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17
and sfsline:stmt_lob not one of 999
list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:premium/total/mask="(ZZZ,ZZZ,ZZZ.99)"
