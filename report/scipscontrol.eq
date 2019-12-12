define string l_dec1 = scipscontrol:cpp_dec_page_to_use[1]
define string l_dec2 = scipscontrol:cpp_dec_page_to_use[2]

list
/nobanner
/domain="scipscontrol"

box/noblanklines 
scipscontrol:state
scipscontrol:lob_code 
scipscontrol:dec_page_to_use 
scipscontrol:cpp_dec_page_to_use[1]
scipscontrol:cpp_dec_page_to_use[2] 
scipscontrol:cpp_dec_page_to_use[3]
scipscontrol:cpp_dec_page_to_use[4]
scipscontrol:cpp_dec_page_to_use[5]
scipscontrol:cpp_dec_page_to_use[6]
scipscontrol:cpp_dec_page_to_use[7]
scipscontrol:ca_id_card_to_use
scipscontrol:ca_id_card_to_use2

end box 

sorted by scipscontrol:state /newlines 
          scipscontrol:lob_code 
--l_dec1
--scipscontrol:dec_page_to_use 
/*
end of scipscontrol:dec_page_to_use 
box/noblanklines/noheadings  
scipscontrol:state
scipscontrol:lob_code 
scipscontrol:dec_page_to_use 
--scipscontrol:cpp_dec_page_to_use[1]
--scipscontrol:cpp_dec_page_to_use[2] 
end box 
*/

/*
end of l_dec1
box/noblanklines/noheadings  
scipscontrol:state
scipscontrol:lob_code 
l_dec1
--scipscontrol:cpp_dec_page_to_use[1]
--scipscontrol:cpp_dec_page_to_use[2] 
end box 
*/
