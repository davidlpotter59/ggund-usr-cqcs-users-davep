define string l_sfs[3] = "SFS"
define unsigned ascii number l_state_no[2] = 29
define unsigned ascii number l_line_of_business[2] = 8

define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 

define file sfsoptenda = access sfsoptend, set sfsoptend:company_id        = sfsdefaulta:company_id,
                                               sfsoptend:state             = l_state_no, 
                                               sfsoptend:line_of_business  = l_line_of_business,
                                               sfsoptend:code              = sfpend:code, generic
 
define file sfsoptend1a = access sfsoptend1, set sfsoptend1:company_id        = sfsdefaulta:company_id, 
                                                 sfsoptend1:state             = l_state_no,  
                                                 sfsoptend1:line_of_business  = l_line_of_business, 
                                                 sfsoptend1:code              = sfpend:code, generic  


where sfpmaster:state one of l_state_no and 
      sfpname:line_of_business one of l_line_of_business and
      sfpname:status one of "CURRENT" 


list
/nobanner
/domain="sfpend" 
/nodetail


sfsoptenda:code 
sfsoptenda:description 
sfsoptend1a:pcl_doc_was_converted /column=100

sorted by sfsoptenda:code 

end of sfsoptenda:code 
box/noblanklines/noheadings 
if sfsoptenda:typed_form one of 1 then
{
   sfsoptenda:code 
   sfsoptenda:description 
   sfsoptend1a:pcl_doc_was_converted  /align=sfsoptend1a:pcl_doc_was_converted
}
end box
