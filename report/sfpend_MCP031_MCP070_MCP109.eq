
where (sfpend:code one of "MCP031", "MCP070", "MCP109" 
or pos("109", sfpend:form_edition) <> 0 
or pos("ANTENNA",sfpend:DESCRIPTION ) <> 0
or pos("antenna",sfpend:description) <> 0 )
and sfpname:status one of "CURRENT"

list
/nobanner
/domain="sfpend"
/title="Policies with MCP031, MCP070 and MCP109"

sfpend:policy_no 
sfpend:code 
sfpend:form_edition 
sfpend:description

sorted by sfpend:code/newlines /count
