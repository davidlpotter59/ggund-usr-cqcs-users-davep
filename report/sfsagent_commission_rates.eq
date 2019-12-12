define wdate l_starting_date = todaysdate 

define string l_subline[2]="00"

define file sfslinea = access sfsline, set sfsline:company_id= sfsagent:company_id, 
                                           sfsline:line_of_business= sfsagtcomm:line_of_business, 
                                           sfsline:lob_subline= l_subline 

where sfsagent:agent_No < 9990
and sfsagtcomm:exp_date = 00.00.0000

list
/nobanner
/domain="sfsagent"
/title="Agents Commission by Line"

sfsagent:agent_no
sfsagent:name[1]/noheading 
sfsagtcomm:eff_date 
sfsagtcomm:exp_date 
sfsagtcomm:line_of_business
sfslinea:description /noheading  
sfsagtcomm:comm_rate

sorted by sfsagent:agent_no /newlines 

top of page  
enquiryname                      /heading="Report No      "/column=1/newline 
--L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompany:name[1])/column=1/heading="Company Name   "/newline  
trun(str(l_starting_date,"MM/DD/YYYY") )/column=1/heading=
"Report Period  "/newline
