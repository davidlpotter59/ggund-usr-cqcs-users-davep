viewpoint native;
--where agqname:agent_no one of 266
where pos("PLAY",agqname:name[1]) <> 0 or 
      pos("PLAY",agqname:name[2]) <> 0 or 
      pos("PLAY",agqname:name[3]) <> 0 
      
list/nobanner/domain="agqname"
  agqname:app_no 
  agqname:name[1]
  agqname:agent_no 
  agqname:trans_date 
  agqname:eff_date 
  agqname:status

sorted by agqname:name[1]
