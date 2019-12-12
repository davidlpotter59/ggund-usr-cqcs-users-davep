#!/bin/bash

PATH=/data/axis
PATH=$PATH:/data/csexec
PATH=$PATH:/data/axis/lib730_3a
PATH=$PATH:/usr/cqcs/server7.30_3a
PATH=$PATH:/usr/cqcs/license
PATH=$PATH:/software/shells
PATH=$PATH:/software/source/scips/version730_3a/dm
PATH=$PATH:/usr/cqcs/server7.30_3a/dm
PATH=$PATH:/software/source/cvs_projects/davep
PATH=$PATH:.
PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/etc/bin
PATH=$PATH:/etc
PATH=$PATH:/usr/local/bin
PATH=$PATH:/sbin
PATH=$PATH:/software/source/scips/version7/includes/ggunder

export PATH

VCQ_DBPATH=/data/axis
export VCQ_DBPATH

cd /data/axis

prspremloss_combined.mk
rm prspremloss_flat
rm prspremloss_starr_flat
rm prspremloss_delos_flat

cd /usr/cqcs/users/davep/report/combined

cq prspremlosscnv

# dcheck /data/axis_debug3/prspremloss_combined
#  echo Empty File
# read me

csbatch prspremlosscombined
# dcheck /data/axis_debug3/prspremloss_combined
# echo AFTER Just AXIS
# read me 

csbatch prspremlosscombined_delos
# dcheck /data/axis_debug3/prspremloss_combined
# echo AFTER AXIS and DELOS
# read me

csbatch prspremlosscombined_starr
# dcheck /data/axis_debug3/prspremloss_combined
# echo AFTER AXIS,DELOS and STARR
# read me

