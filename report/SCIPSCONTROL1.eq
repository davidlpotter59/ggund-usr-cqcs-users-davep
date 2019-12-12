viewpoint native;

--WHERE SCIPSCONTROL1:STATE = 7


list/nobanner/domain="scipscontrol1"
  scipscontrol1:state 
  scipscontrol1:lob_code 
  print_policy_form_on_all_decs /heading="Declaraion"
  scipscontrol1:print_common_policy_form_on_dec /heading="Common"
  scipscontrol1:print_policy_form_on_cpp_decs[1] /heading="Extra Dec 1"
  scipscontrol1:print_policy_form_on_cpp_decs[2] /heading="Extra Dec 2" 
  scipscontrol1:print_policy_form_on_cpp_decs[3] /heading="Extra Dec 3" 
  scipscontrol1:print_policy_form_on_cpp_decs[4] /heading="Extra Dec 4" 
  scipscontrol1:print_policy_form_on_cpp_decs[5] /heading="Extra Dec 5"

sorted by
  scipscontrol1:state/newline
  scipscontrol1:lob_code
