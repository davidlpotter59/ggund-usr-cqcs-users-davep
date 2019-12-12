viewpoint native;

define string l_sfs[3]="SFS"
define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs
 
define file sfslinea = access sfsline, set sfsline:company_id= sfsdefaulta:company_id, 
                                           sfsline:line_of_business= policy_count:lob, 
                                           sfsline:lob_subline= "00"
define unsigned ascii number l_count = if policy_count:status = "ACTIVE" then 1 else -1

where policy_count:status one of "ACTIVE"

list
/nobanner
/domain="policy_count"
/nodetail 

  policy_count:policy_no 
  policy_count:status /heading="Status"
  policy_count:lob /name="Line_of_business"
  policy_count:lob_subline /heading="Subline"
  policy_count:state /heading="State"
  policy_count:agent/heading="Agent"

sorted by policy_count:lob 
          policy_count:policy_no 

top of policy_count:lob 
""/newline 
box/noblanklines/noheadings 
   policy_count:lob /column=1
   sfslinea:description
end box 
""/newline 

end of policy_count:lob 
""/newline 
"Total inforce policies for " + trim(sfslinea:description) + "   " + str(total[l_count ])

end of policy_count:policy_no 
box/noblanklines/noheadings 
   policy_count:policy_no/align=policy_count:policy_no  
   policy_count:status /align=policy_count:status 
   policy_count:lob /align=line_of_business  
   policy_count:lob_subline /align=policy_count:lob_subline 
   policy_count:state /align=policy_count:state 
   policy_count:agent/align=policy_count:agent 
end box 

end of report 
""/newline 
"Total inforce policy count for all lines " total[l_count ]
