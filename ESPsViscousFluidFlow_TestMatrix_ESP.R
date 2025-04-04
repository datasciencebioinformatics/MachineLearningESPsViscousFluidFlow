ggplot(merge_water_viscous, aes(x=as.numeric(Inlet.Viscosity.mi))) + geom_histogram(color="darkblue", fill="lightblue",bins=200) +scale_x_continuous(breaks = seq(0, 1300, by = 50))


# Start inlet viscosity variable to determine the value category
merge_water_viscous$Inlet.Viscosity<-0

merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 10),"Inlet.Viscosity"]<-0

merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 10 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 30),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 55 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 100),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 101 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 200),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 201 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 275),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 276 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 400),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 401 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 600),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 601 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 725),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 726 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 950),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 951 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 1150),"Inlet.Viscosity"]
merge_water_viscous[which(as.numeric(merge_water_viscous$Inlet.Viscosity.mi) > 1151 & as.numeric(merge_water_viscous$Inlet.Viscosity.mi) < 1500),"Inlet.Viscosity"]


[0-10]
[11-30]
[31-55]
[55-100]
[101-200]
[201-275]
[276-400]
[401-600]
[601-725]
[726-950]
[951-1150]
[1150-1500]

