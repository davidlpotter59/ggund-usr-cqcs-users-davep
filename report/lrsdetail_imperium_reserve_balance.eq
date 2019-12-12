include "startend.inc"

define signed ascii number l_2017_itd_reserve = if lrsdetail:trans_date <= 12.31.2017 then lrsdetail:loss_resv else 0
define signed ascii number l_2018_itd_reserve = if lrsdetail:trans_date <= l_ending_date then lrsdetail:loss_resv else 0

define signed ascii number l_diff_reserve = l_2018_itd_reserve - l_2017_itd_reserve 

where
lrsdetail:trans_code < 30 
and lrsdetail:trans_date => l_starting_date 
and lrsdetail:trans_date <= l_ending_date 

and lrsdetail:claim_no one of 1094563224, 1094563520, 44410010041,
        44411030007, 44411070037, 44412030025, 44413080002, 44413090006,
        44415080002, 44416040001, 44416060001, 44416080001, 44417040001,
        44417060001, 44417090001, 44417110001, 44417110002, 44417110003,
        44418010001, 44418030001, 44418040001

list
/nobanner
/domain="lrsdetail"
/nodetail 
/nototals   

lrsdetail:claim_no 
l_2017_itd_reserve/heading="2017 ITD Reserves"/mask="(ZZZ,ZZZ,ZZZ.99)"
l_2018_itd_reserve/heading="2018 ITD Reserves"/mask="(ZZZ,ZZZ,ZZZ.99)"
l_diff_reserve /heading="Change in Reserves"/mask="(ZZZ,ZZZ,ZZZ.99)"
loss_resv/mask="(ZZZ,ZZZ,ZZZ.99)" 
loss_paid/mask="(ZZZ,ZZZ,ZZZ.99)" 
lae_resv/mask="(ZZZ,ZZZ,ZZZ.99)" 
lae_paid/mask="(ZZZ,ZZZ,ZZZ.99)"

sorted by lrsdetail:claim_no--/newlines /total

end of lrsdetail:claim_no 
box/noheadings/noblanklines
if total[lrsdetail:loss_resv] <> 0 then 
{ 
  lrsdetail:claim_no 
  total[l_2017_itd_reserve]/align=l_2017_itd_reserve /mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_2018_itd_reserve]/align=l_2018_itd_reserve /mask="(ZZZ,ZZZ,ZZZ.99)"
  total[l_diff_reserve] /align=l_diff_reserve /mask="(ZZZ,ZZZ,ZZZ.99)"

  total[loss_resv]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail:loss_resv 
  total[loss_paid]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail:loss_paid 
  total[lae_resv]/mask="(ZZZ,ZZZ,ZZZ.99)" /align=lrsdetail:lae_resv 
  total[lae_paid]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=lrsdetail:lae_paid 
}
end box
