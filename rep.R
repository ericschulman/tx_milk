#Dependencies ---------------------------
rm(list=ls())
source("~/Documents/tx_milk/models.R")

#import data and set up correct ---------------------------
input_dir <- "~/Documents/tx_milk/input/clean_milk.csv"
milk <- load_milk(input_dir)
milk <- milk[which(milk$year <=1991), ]


#Run functions on all data ---------------------------
out_dir<-"~/Documents/tx_milk/output/rep/tables/"
dir.create(out_dir, showWarnings = FALSE)

fit<-table5(milk,out_dir,"Reproduced Table 5 Results (All ISDs 1980-1991)")
fit2<-table6(milk,out_dir,"Modified Table 6 Results (All ISDs 1980-1991)")


#Run functions on Dallas data ---------------------------
#set up Dallas data
milk_dfw<-milk[which(milk$fmozone==1 & milk$year <=1991), ]

out_dir_dfw<-"~/Documents/tx_milk/output/rep/tables_dfw/"
dir.create(out_dir_dfw, showWarnings = FALSE)

fit_dfw<-table5(milk_dfw,out_dir_dfw,"Reproduced Table 5 Results (Dallas Ft. Worth 1980-1991)")
fit_dfw<-table6(milk_dfw,out_dir_dfw,"Reproduced Table 6 Results (Dallas Ft. Worth 1980-1991)")


#Run functions on SA data ---------------------------
#set up SA data
milk_sa<-milk[which(milk$fmozone==9 & milk$year >= 1988 & milk$year <=1991), ]

out_dir_sa<-"~/Documents/tx_milk/output/rep/tables_sa/"
dir.create(out_dir_sa, showWarnings = FALSE)

fit_sa<-table6(milk_sa,out_dir_sa,"Reproduced Table 6 Results (San Antonio 1988-1991)")
fit_sa1<-table10(milk_sa,out_dir_sa,"Reproduced Table 10 Results (San Antonio 1988-1991)")


# 'Broken' Regression ---------------------------
out_dir_m<-"~/Documents/tx_milk/output/rep/tables_m/"
dir.create(out_dir_m, showWarnings = FALSE)

#set up data
milk_m0<-milk[which(milk$fmozone==9 & milk$year >= 1980 & milk$year <=1991), ]
milk_m1<-milk[which(milk$fmozone==9 & milk$year >= 1980 & milk$year <=1987), ]
milk_m2<-milk[which(milk$fmozone==9 & milk$year >= 1980 & milk$year <=1983), ]
milk_m3<-milk[which(milk$fmozone==9 & milk$year >= 1984 & milk$year <=1987), ]

fit_sa1<-table6(milk_m0,out_dir_m,"Reproduced Table 6 Results (San Antonio 1980-1991)")
fit_sa1<-table6(milk_m1, out_dir_m, "Reproduced Table 6 Results (San Antonio 1980-1987)", fname="table61.tex")
fit_sa2<-table6(milk_m2, out_dir_m, "Reproduced Table 6 Results (San Antonio 1980-1983)", fname="table62.tex")
fit_sa3<-table6(milk_m3, out_dir_m, "Reproduced Table 6 Results (San Antonio 1984-1987)", fname="table63.tex")


#Hypothesis tests ---------------------------
linearHypothesis(fit, c("(Intercept)=inc","type_dumlfc=inc:type_dumlfc",
                        "type_dumlfw=inc:type_dumlfw","type_dumwc=inc:type_dumwc",
                        "lfmo = inc:lfmo","lqstop=inc:lqstop",
                        "lback=inc:lback","esc=inc:esc","lnum=inc:lnum" ))