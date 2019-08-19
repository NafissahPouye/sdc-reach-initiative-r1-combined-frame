library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-reach-initiative-r1-combined-frame")
data <- read_excel("data.xlsx", sheet = "combined_frame")
#Resource1 - Main Frame
#Comments - contain id that should be removed
selectedKeyVars <- c(	'hh_memb_age','hh_memb_sex',	'hh_mem_employment',
                      'area_employment_hh_member_KOATUU',
                      'area_employment_hh_member_name',
                      'hh_memb_employment_2013', 
                      'area_hh_memb_employment_2013_KOATUU',
                      'area_hh_memb_employment_2013_name',	
                      'sector_hh_memb_employed', 
                      'hh_memb_income',	'hh_memb_displacement_status',
                      'hh_memb_vulnerability', 'hh_memb_disability_type',
                      'hh_memb_receive_edu', 'cva_area'
                     )
weightVars <- c('Weight_by_cva_area')
#Convert variables into factors
cols =  c('hh_memb_age','hh_memb_sex',	'hh_mem_employment',
          'area_employment_hh_member_KOATUU',
          'area_employment_hh_member_name',
          'hh_memb_employment_2013', 
          'area_hh_memb_employment_2013_KOATUU',
          'area_hh_memb_employment_2013_name',	
          'sector_hh_memb_employed', 'hh_memb_displacement_status',
          'hh_memb_vulnerability', 'hh_memb_disability_type',
          'hh_memb_receive_edu', 'cva_area')
data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars
                       )

print(objSDC, "risk")
