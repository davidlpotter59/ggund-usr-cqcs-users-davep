viewpoint native;
--where sfqname:agent_no one of 266
where (pos("MOLLY",sfqname:name[1]) <> 0 or 
       pos("MOLLY",sfqname:name[2]) <> 0 or 
       pos("MOLLY",sfqname:name[3]) <> 0) OR 
(pos("PLAYA",sfqname:name[1]) <> 0 or 
       pos("PLAYA",sfqname:name[2]) <> 0 or 
       pos("PLAYA",sfqname:name[3]) <> 0) OR 
(pos("WALLACE",sfqname:name[1]) <> 0 or 
       pos("WALLACE",sfqname:name[2]) <> 0 or 
       pos("WALLACE",sfqname:name[3]) <> 0) OR
(pos("MECHANICAL",sfqname:name[1]) <> 0 or 
       pos("MECHANICAL",sfqname:name[2]) <> 0 or 
       pos("MECHANICAL",sfqname:name[3]) <> 0) OR
(pos("FORSS",sfqname:name[1]) <> 0 or 
       pos("FORSS",sfqname:name[2]) <> 0 or 
       pos("FORSS",sfqname:name[3]) <> 0) 

AND SFQNAME:AGENT_NO ONE OF 266

list/nobanner/domain="sfqname"
  sfqname:quote_no 
  sfqname:app_no 
  sfqname:name[1]
  SFQNAME:NAME[2]
  SFQNAME:NAME[3]
  sfqname:agent_no 
  sfqname:trans_date 
  sfqname:eff_date 
  sfqname:status

sorted by sfqname:name[1,1]/NEWLINE
