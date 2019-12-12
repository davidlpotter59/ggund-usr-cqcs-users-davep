define string l_sfs[3] = "SFS"
define unsigned ascii number l_state_no[2] = 29
define unsigned ascii number l_line_of_business[2] = 8

define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 

define file sfsoptenda = access sfsoptend, set sfsoptend:company_id        = sfsdefaulta:company_id,
                                               sfsoptend:state             = l_state_no, 
                                               sfsoptend:line_of_business  = l_line_of_business,
                                               sfsoptend:code              = sfpend:code, generic 
 
define string l_form = if sfsoptenda:exp_date = 00.00.0000 then sfsoptenda:code 
define wdate l_exp_date = if sfsoptenda:exp_date = 00.00.0000 then sfsoptenda:exp_date 

define file sfsoptend1a = access sfsoptend1, set sfsoptend1:company_id        = sfsdefaulta:company_id, 
                                                 sfsoptend1:state             = l_state_no,  
                                                 sfsoptend1:line_of_business  = l_line_of_business, 
                                                 sfsoptend1:code              = sfpend:code, generic  


where sfpmaster:state one of l_state_no and 
      sfpname:line_of_business one of l_line_of_business and
      sfpname:status one of "CURRENT" 


list
/domain="sfpend" 
/hold="ends_used"
/nodetail 


sorted by sfpend:policy_no 
          sfpend:code

end of sfpend:code
{
sfpend:policy_no /keyelement=1
sfpend:code /keyelement=2
sfsoptenda:typed_form
sfsoptenda:form_print 
sfsoptenda:trigger_endorsement 
sfsoptenda:exp_date 
l_form/name="form"
l_exp_date /name="ExpDate"
}
