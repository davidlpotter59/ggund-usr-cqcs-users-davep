viewpoint native;

where 
scipscontrol:lob_code one of
    "AUTO", "BOP", "CINLAND", "LIABILITY", "PROPERTY", "SCP", "SMP", "UMBRELLA"

list/nobanner/nototals/domain="scipscontrol"
  scipscontrol:state 
  scipscontrol:lob_code 

  scipscontrol:font_to_use_1[1]/heading="Name Font"

  str(scipscontrol:horizontal_position [1]) + " / " + str(scipscontrol:veritical_position [1])/heading="Name H / V POS Line 1"
  str(scipscontrol:horizontal_position [2]) + " / " + str(scipscontrol:veritical_position [2])/heading="Name H / V POS Line 2"
  str(scipscontrol:horizontal_position [3]) + " / " + str(scipscontrol:veritical_position [3])/heading="Name H / V POS Line 3"

  scipscontrol:font_to_use_1[2]/heading="Address Font"

  str(scipscontrol:horizontal_position [4]) + " / " + str(scipscontrol:veritical_position [4])/heading="Address H / V POS Line 1"
  str(scipscontrol:horizontal_position [5]) + " / " + str(scipscontrol:veritical_position [5])/heading="Address H / V POS Line 2"
  str(scipscontrol:horizontal_position [6]) + " / " + str(scipscontrol:veritical_position [6])/heading="Address H / V POS Line 3"

  scipscontrol:font_to_use_1[2]/heading="Company Name Font"
  str(scipscontrol:horizontal_position [7]) + " / " + str(scipscontrol:veritical_position [7])/heading="Company Name H / V Pos"

  scipscontrol:font_to_use_1[2]/heading="Company Logo Font"
  str(scipscontrol:horizontal_position [8]) + " / " + str(scipscontrol:veritical_position [8])/heading="Company Logo H / V Pos"

  scipscontrol:font_to_use_1[2]/heading="Company Incorp Font"
  str(scipscontrol:horizontal_position [9]) + " / " + str(scipscontrol:veritical_position [9])/heading="Company Incorp H / V Pos"

  scipscontrol:font_to_use_1[2]/heading="Policy Dec Font"
  str(scipscontrol:horizontal_position [10])+ " / " + str(scipscontrol:veritical_position [10])/heading="Policy Dec H / V Pos"

  scipscontrol:font_to_use /heading="Telephone Font" 
  str(scipscontrol:horizontal_position_1) + " / " + str(scipscontrol:vertical_position_1)/heading="Telephone H / V Poistion"

sorted by scipscontrol:lob_code/newlines 
          scipscontrol:state
