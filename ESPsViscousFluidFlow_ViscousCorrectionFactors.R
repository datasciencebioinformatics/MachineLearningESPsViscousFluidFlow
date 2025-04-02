# The correction factors for flow rate (CQ)
# Take the flow rate from water samples
merge_water_viscous[which(merge_water_viscous$fluid!="water"),"Q"]/merge_water_viscous[which(merge_water_viscous$fluid=="water"),"Q"]
 

# homologous conditions on the viscous and water curves

# CQ= Qvis/Qw
