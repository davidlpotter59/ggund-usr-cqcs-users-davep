define string l_form = parameter/prompt="Enter Form to find policies for"/uppercase 

define string l_sfs[3]="SFS"
define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 

define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= sfpname:policy_no 

define file sfplocationa = access sfplocation, set  sfplocation:POLICY_NO    = sfpcurrenta:policy_no, 
                                                    sfplocation:POL_YEAR     = sfpcurrenta:pol_year, 
                                                    sfplocation:END_SEQUENCE = sfpcurrenta:end_sequence,generic 
--where pos(l_form,sfpend:code) <> 0
/*where pos(l_form,sfpend:form_edition) <> 0 
and sfpname:exp_date > todaysdate 
and sfpname:status ="CURRENT"*/

where sfpname:line_of_business one of 51
and sfpname:status = "CURRENT"
and sfpname:eff_date > 01.01.2019
list
/nobanner
/domain="sfpname" 
/duplicates 

sfpname:policy_no 
sfpname:name[1]
sfpname:line_of_business 
sfplocationa:state /duplicates 
sfpend:form_edition 
sfpend:code /duplicates 

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
