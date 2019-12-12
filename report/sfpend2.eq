--include "ending.inc"

define string l_mandatory = if pos("*",sfpend:form_edition) <> 0 then "Mandatory" else "Optional"

--where sfpend:exp_date = 00.00.0000 or 
--      sfpend:exp_date => l_ending_date 

--where pos("MCS",sfpend:code) <> 0 --  one of "MCS90"

list
/nobanner
/domain="sfpend"
/title="Forms used By State, Line and Mandatory or Optional"
--/nodetail 

sfpend:policy_no 
--sfpend:state 
--sfpend:line_of_business /heading="LOB"
--l_mandatory/heading="Mandatory or-Optional"
--sfpend:form
sfpend:code
--sfpend:eff_date 
--sfpend:exp_date 
sfpend:form_edition 
sfpend:description 

sorted by sfpend:form_edition 
--sfpend:policy_no  
--          sfpend:state
--          sfpend:line_of_business
        --  sfpend:form 
          sfpend:form_edition
