where pos("POLICY",sfscsexec:application) <> 0
and sfscsexec:application_number > 0

list
/nobanner
/domain="sfscsexec"

sfscsexec:application/heading="Line Type"
sfscsexec:application_number/heading="Starting-Policy-Number"
