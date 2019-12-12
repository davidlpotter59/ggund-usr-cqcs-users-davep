description This report prints the commissions table be agent and line of business ;

viewpoint native;
define wdate l_starting_date = 01.01.2000
define wdate l_ending_date = todaysdate 

define string l_sfs[3] = "SFS"
define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code  = l_sfs
define file sfscompanya = access sfscompany, set sfscompany:company_id = sfsdefaulta:company_id 

define file sfsagenta = access sfsagent, set sfsagent:company_id = sfsdefaulta:company_id, 
                                             sfsagent:agent_no   = sfsagtcomm:agent_no 

where sfsagtcomm:agent_no = sfsagenta:agent_no 

list/nobanner/domain="sfsagtcomm"/title="Agent's Commission Rate Table"

if sfsline:description <> "" then 
{
  sfsagtcomm:agent_no 
  sfsagtcomm:line_of_business
  sfsline_heading:description 
  sfsagtcomm:eff_date 
  sfsagtcomm:exp_date 
  sfsagtcomm:comm_rate /heading="New-Commission-Rate"
  sfsagtcomm:renewal_comm_rate /heading="Renew-Commission-Rate"
  sfsagtcomm:boiler_comm 
  sfsagtcomm:identity_theft_comm 
}

  sorted by sfsagtcomm:agent_no/newlines 
            sfsagtcomm:state
            sfsagtcomm:Line_of_business             

top of sfsagtcomm:agent_no 
box/noblanklines/noheadings 
   str(sfsagtcomm:agent_no) + "  " + sfsagenta:name[1] 
end box
""/newline 

top of page  
enquiryname                      /heading="Report No      "/column=1/newline 
--L_prog_number                    /heading="Report No      "/column=1/newline 
trun(sfscompanya:name[1] )/column=1/heading="Company Name   "/newline  
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/column=1/heading=
"Report Period  "/newline
