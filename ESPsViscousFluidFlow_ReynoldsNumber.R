#########################################################################################################
# Path to metadata file
metada_data_file="eps_metada.xlsx"

# Load the metada file
metada_data<-data.frame(read_excel(paste(project_folder,metada_data_file,sep=""),skip=1))

# Split data.frame into RPM and rads
metada_data_rpm <-cbind(metada_data[,c(1,2,3,4,5,6)],Metric="RPM")
metada_data_rads<-cbind(metada_data[,c(1,2,7,8,9,10)],Metric="rads")

# Split data.frame into RPM and rads
colnames(metada_data_rpm)<-c("model","Impeller.diameter","1800","2400","3000","3500","Metric")
colnames(metada_data_rads)<-c("model","Impeller.diameter","1800","2400","3000","3500","Metric")

# Compile metada data
metada_data<-rbind(metada_data_rpm,metada_data_rads)
#########################################################################################################
# Calculation of Reynolds number
All_viscous$Re_a<-0 # Coeficiente de Reynolds (Reynolds number)
All_viscous$Re_b<-0 # https://www.sciencedirect.com/science/article/abs/pii/S2949891024002410

# Re	=	número de Reynolds
# Ρ	=	densidade do fluido
# Μ	=	velocidade do fluxo
# L	=	dimensão linear característica
# υ	=	viscosidade dinâmica do fluido

# P=Inlet.Density.ρi
# M=Flow.rate
# L=Impeller.diameter
# υ=Outlet.Viscosity.mo

Q: Volume per unit time, such as cubic meters per second (\(m^{3}/s\)) 
v: Velocity, such as meters per second (\(m/s\)) 
A: Cross-sectional area, such as square meters (\(m^{2}\)

# Calculate the velocity
for (measure in rownames(All_viscous))
{
  # The Flow Rate, Q (kg/h)
  Q=as.numeric(All_viscous[measure,"Flow.rate"])

  # Density (kg/m³) in (kg/l)
  Inlet.Density.ρi=as.numeric(All_viscous[measure,"Inlet.Density.ρi"])/1000 

  # The Flow Rate, Q (kg/h) in l/s 
  # Liter per second, check liter per second
  Q    = (Q/3600)*Inlet.Density.ρi

  # Inner diameter of pipe, di in m
  di  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 

  # Area from pipe
  # áread in m2
  A   <- pi*((di/2)^2)

  
  # Q: Is the volumetric flow rate, measured in volume per unit time
  # v: Is the velocity of the fluid, measured in meters per second (m/s)
  # A: Is the cross-sectional area of the pipe, measured in meters squared (m2)
  # Velocity m/s
  # Q in l/s
  # A in m2
  v = Q/A
}

# To calculate the velocity of a fluid from its flow rate, you can use the formula \(v=Q/A\). In this formula, \(v\) is the velocity, \(Q\) is the flow rate, and \(A\) is the cross-sectional area. 
# cross-sectional area -> A = pi*(L/2)^2
# velocity=Flow.rate/A
# For each measure
for (measure in rownames(All_viscous))
{
  #####################################################################################
  # Take the equipment
  equip<-All_viscous[measure,"equip"]
  F  <-as.numeric(All_viscous[measure,"Flow.rate"])
  L  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 
  υ  <-as.numeric(All_viscous[measure,"Outlet.Viscosity.mo"])
  RPM<-All_viscous[measure,"RPM"]
  w<-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads" ,RPM]) 
  
  # Here I must check how I calculated the aread from the Impeller.diameter.
  # The formula for the area of an impeller is \(Area=\pi d^{2}\), where \(d\) is the impeller's diameter. 
  # A (m2)
  # F (kg/h)
  # w (rad/s)
  # velocity (kg/h / m2 )
  A       <- pi*(L/2)^2
  velocity<-F/A 
  #####################################################################################
  # https://www.google.com/search?q=Coeficiente+de+Reynolds+%28Reynolds+number%29%0D%0A&sca_esv=f731f35a248a5872&sxsrf=AHTn8zqkqYIW--AtUKUwp9RomTfTwkr7Cg%3A1743079038717&ei=fkblZ4_CK-2H4dUPjPHh4Qk&ved=0ahUKEwiP-au3o6qMAxXtQ7gEHYx4OJwQ4dUDCBA&uact=5&oq=Coeficiente+de+Reynolds+%28Reynolds+number%29%0D%0A&gs_lp=Egxnd3Mtd2l6LXNlcnAiKkNvZWZpY2llbnRlIGRlIFJleW5vbGRzIChSZXlub2xkcyBudW1iZXIpCkgAUABYAHAAeAGQAQCYAQCgAQCqAQC4AQPIAQD4AQL4AQGYAgCgAgCYAwCSBwCgBwCyBwC4BwA&sclient=gws-wiz-serp
  # Reynolds number formula a :  # Coeficiente de Reynolds (Reynolds number)
  Re_A = (P*velocity*L)/υ
  #####################################################################################
  # https://www.sciencedirect.com/science/article/abs/pii/S2949891024002410
  # Gülich (2008)
  # valid for viscosities up to 4000 mm2/s and specific speed between 0.132 < 𝜔𝑠 < 0.936
  Re_w<-(w*(L^2))/velocity

  # w_s : 𝜔 is the rotational speed in rad/
  Re_gulich <-Re_w*w
  
  # w : is the rotational speed in rad/s
  # where 𝑅𝑒𝜔 is the dimensionless rotational Reynolds number, given as:
  # 𝑟2 is the impeller outer diameter.
  # 𝑎 Original=1.5 Optimized=2.06 
  #####################################################################################
  
  # Set the reynolds number
  All_viscous[measure,"Re_a"]<-Re_A
  All_viscous[measure,"Re_b"]<-Re_B
}
