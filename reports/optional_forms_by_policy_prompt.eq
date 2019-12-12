define string l_form = parameter/prompt="Enter Form to find policies for"/uppercase 

define string l_sfs[3]="SFS"
define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 

define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= sfpname:policy_no 

define file sfplocationa = access sfplocation, set  sfplocation:POLICY_NO    = sfpcurrenta:policy_no, 
                                                    sfplocation:POL_YEAR     = sfpcurrenta:pol_year, 
                                                    sfplocation:END_SEQUENCE = sfpcurrenta:end_sequence,generic 

--where pos(l_form,sfpoptend:code) <> 0
where pos(l_form, sfp
and sfpname:exp_date > todaysdate 
and sfpname:status ="CURRENT"

list
/nobanner
/domain="sfpoptend" 

sfpoptend:policy_no 
sfpname:name[1]
sfplocationa:state /duplicates 
sfpoptend:form_edition 

sorted by sfplocationa:state /newlines 
          sfpname:policy_no 

top of sfplocationa:state 
box/noblanklines/noheadings 
  "State:   " sfplocationa:state  
end box

top of page
box/noblanklines/noheadings 
  l_form/heading="Form"
end box
