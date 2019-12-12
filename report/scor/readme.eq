list
/nobanner
/domain="sfsdefault"
/nodefaults 
/pagelength=0
/nodetail 

end of report 

""/newline=2
"NOTE:  YOU MUST RUN aggregate_limit_loc before any of the reports below"/newline=2

"##########################################################"/newline
"###"/newline
"###  this document is only to assit G and G in what"/newline
"###  reports to run for the monthly submission to GSN"/newline
"###"/newline
"##########################################################"/newline
""/newline=2
"gsn_auto_bdx"/newline 
" - this is run once a month using the"/newline
"               first and last day of the prior month"/newline
""/newline=2
"**********************************************************"/newline
"***  The following reports are ONLY RUN AFTER the"/newline
"***  Aggregate_Limit_Loc report gets run in the utilities"/newline
"***  folder."/newline
"**********************************************************"/newline
""/newline=2
"gsn_rms_aggregate_rms_wind"/newline 
" (Wind Monitor) -"/newline
"               this is run after the inhouse"/newline
"               aggregate reports are run so that the data"/newline
"               is setup.  This is the new version of the"/newline
"               report with the GSN requested columns added"/newline
"               and the modfied default values"/newline
""/newline=2 
"gsn_county_rms_aggregate_rms_wind"/newline 
" - this is the new report"/newline
"               to monitor the wind distribution for selected"/newline
"               counties in NJ"/newline
""/newline
