-- MCL 202 06 05

--where pos("202",sfpend:form_edition  ) <> 0
--and sfpend:exp_date = 00.00.0000
where (sfpend:code one of "MCP031", "MCP070", "MCP109" or pos("109", sfpend:form_edition) <> 0 or pos("ANTENNA",SFPEND:DESCRIPTION ) <> 0)
and sfpname:status one of "CURRENT"

list
/nobanner
/domain="sfpend"
/title="Policies with MCP031, MCP070 and MCP109"

sfpend:policy_no 
--sfsline_heading:description 
sfpend:code 
sfpend:form_edition 
sfpend:description

sorted by sfpend:code/newlines /count
