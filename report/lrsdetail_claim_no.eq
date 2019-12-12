include "startend.inc"

define string l_prog_number = "Claim Dump"

--where lrsdetail:claim_no one of 1093400096, 1093400045, 1093035114, 1093035115, 1093035144 

list
/nobanner
/domain="lrsdetail"
/nodetail 
/noreporttotals 

lrsdetail:claim_no /column=1
lrssetup:policy_no /column=15
lrssetup:agent_no /column=30
lrsdetail:loss_resv /column=40
lrsdetail:loss_paid /column=60
lrsdetail:lae_resv /column=80
lrsdetail:lae_paid /column=100

sorted by lrsdetail:claim_no 

end of lrsdetail:claim_no 
box/noheadings 
    lrsdetail:claim_no /column=1
    lrssetup:policy_no /column=15
    lrssetup:agent_no /column=30
    total[lrsdetail:loss_resv] /column=40
    total[lrsdetail:loss_paid] /column=60
    total[lrsdetail:lae_resv] /column=80
    total[lrsdetail:lae_paid] /column=100
end box

end of report  
box/noheadings 
    ""/newline 
    total[lrsdetail:loss_resv] /column=40
    total[lrsdetail:loss_paid] /column=60
    total[lrsdetail:lae_resv] /column=80
    total[lrsdetail:lae_paid] /column=100
end box

top of page  
L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/column=1/heading="Company Name   "/newline  
"No Report Period"/column=1/noheading/newline
