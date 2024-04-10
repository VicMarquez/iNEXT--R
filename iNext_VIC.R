## Análisis de Diversidad con iNext

#Biblio de referencia: https://cran.r-project.org/web/packages/iNEXT/vignettes/Introduction.html


## install iNEXT package from CRAN
install.packages("iNEXT")

## import packages
library(iNEXT)
library(ggplot2)

#Ejemplo con datos de abundancia
data(spider)
spider
str(spider)
iNEXT(spider, q=0, datatype="abundance")


#Archivo con datos de Incidencia de las spp por Condición: "Sp x Condición.txt"

data<- read.table(file.choose(), header = TRUE)
head(data)
lapply(data, as.incfreq) # transform incidence raw data (a species by sites presence-absence matrix) to incidence frequencies data
                         #(iNEXT input format, a row-sum frequencies vector contains total number of sampling units).

str(data)
iNEXT(data, q=0, datatype="incidence_freq")

#Compare 2 assemblages with Hill number order q = 0.
#$class: iNEXT
#
#$DataInfo: basic data information
#           site T   U S.obs     SC Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9 Q10
#1     Campesino 6 193    60 0.9359 15  8 13  8  5 11  0  0  0   0
#2 Silvopastoril 6 183    68 0.9017 23 16  9  7  5  8  0  0  0   0

#Referencias: Tamaño muestral (T), riqueza observada (S.obs), la estimación de cobertura o completitud del muestreo (SC)

#
#$iNextEst: diversity estimates with rarefied and extrapolated samples.
#$Campesino
#t           method order     qD qD.LCL qD.UCL    SC SC.LCL SC.UCL
#1   1 interpolated     0 32.167 29.947 34.386 0.642  0.589  0.696
#2   1 interpolated     0 32.167 29.947 34.386 0.642  0.589  0.696
#3   1 interpolated     0 32.167 29.947 34.386 0.642  0.589  0.696
#4   1 interpolated     0 32.167 29.947 34.386 0.642  0.589  0.696
#5   1 interpolated     0 32.167 29.947 34.386 0.642  0.589  0.696
#10  3 interpolated     0 50.250 46.871 53.629 0.869  0.832  0.906
#11  3 interpolated     0 50.250 46.871 53.629 0.869  0.832  0.906
#12  3 interpolated     0 50.250 46.871 53.629 0.869  0.832  0.906
#13  3 interpolated     0 50.250 46.871 53.629 0.869  0.832  0.906
#14  3 interpolated     0 50.250 46.871 53.629 0.869  0.832  0.906
#20  6     observed     0 60.000 54.758 65.242 0.936  0.903  0.969
#29  9 extrapolated     0 65.158 57.829 72.487 0.964  0.936  0.993
#30  9 extrapolated     0 65.158 57.829 72.487 0.964  0.936  0.993
#31  9 extrapolated     0 65.158 57.829 72.487 0.964  0.936  0.993
#32  9 extrapolated     0 65.158 57.829 72.487 0.964  0.936  0.993
#40 12 extrapolated     0 68.046 58.847 77.244 0.980  0.958  1.000
#
#$Silvopastoril
#t       method order     qD qD.LCL qD.UCL    SC SC.LCL SC.UCL
#1   1 interpolated     0 30.500 27.658 33.342 0.557  0.513  0.602
#2   1 interpolated     0 30.500 27.658 33.342 0.557  0.513  0.602
#3   1 interpolated     0 30.500 27.658 33.342 0.557  0.513  0.602
#4   1 interpolated     0 30.500 27.658 33.342 0.557  0.513  0.602
#5   1 interpolated     0 30.500 27.658 33.342 0.557  0.513  0.602
#10  3 interpolated     0 52.850 48.205 57.495 0.790  0.753  0.826
#11  3 interpolated     0 52.850 48.205 57.495 0.790  0.753  0.826
#12  3 interpolated     0 52.850 48.205 57.495 0.790  0.753  0.826
#13  3 interpolated     0 52.850 48.205 57.495 0.790  0.753  0.826
#14  3 interpolated     0 52.850 48.205 57.495 0.790  0.753  0.826
#20  6     observed     0 68.000 61.634 74.366 0.902  0.866  0.937
#29  9 extrapolated     0 75.180 66.940 83.420 0.953  0.921  0.985
#30  9 extrapolated     0 75.180 66.940 83.420 0.953  0.921  0.985
#31  9 extrapolated     0 75.180 66.940 83.420 0.953  0.921  0.985
#32  9 extrapolated     0 75.180 66.940 83.420 0.953  0.921  0.985
#40 12 extrapolated     0 78.618 68.513 88.723 0.977  0.953  1.000


#$AsyEst: asymptotic diversity estimates along with related statistics.
#           Site         Diversity Observed Estimator  s.e.    LCL     UCL
#1     Campesino  Species richness   60.000    71.719 8.094 63.446  99.853
#2     Campesino Shannon diversity   51.018    57.612 2.588 52.540  62.685
#3     Campesino Simpson diversity   45.817    49.973 2.141 45.817  54.169
#4 Silvopastoril  Species richness   68.000    81.776 7.658 72.982 106.091
#5 Silvopastoril Shannon diversity   55.938    66.306 3.280 59.878  72.734
#6 Silvopastoril Simpson diversity   48.325    54.588 2.707 49.283  59.894

#Grafico las métrias de riqueza y diversidad para cada condición

plot<-iNEXT(data, q=c(0, 1, 2), datatype="incidence_freq")

# Sample-size-based R/E curves, separating by "site""
ggiNEXT(plot, type=1, facet.var="site")

# Sample-size-based R/E curves, separating by order, o sea por indice"
ggiNEXT(plot, type=1, facet.var="order", color.var="site") #La superposición de intervalos de confianza nos dice que no hay diferencias significativas entre la riqeuza o diversidad de las condiciones

#Curva de completitud
ggiNEXT(plot, type=2, facet.var="none", color.var="site") #este gráfico nos dice que el N usado fue bueno


ggiNEXT(plot, type=3, facet.var="order", color.var="site")



########
#Archivo con datos de Abundancia de las spp por Sitio: "Sp x Sitio.txt"
abun<- read.table(file.choose(), header = TRUE)
head(abun)
lapply(abun, as.abucount) #transform abundance raw data (a species by sites matrix) to abundance rwo-sum counts data (iNEXT input format).

iNEXT(abun, q=0, datatype="abundance")
iNEXT(abun, q=1, datatype="abundance") #q=1 es equivalente a la diversidad de Shanon, es decir contemplando la abudancia de las spp.


plot1<-iNEXT(abun, q=c(0, 1, 2), datatype="abundance")

# Sample-size-based R/E curves, separating by order, o sea por indice"
ggiNEXT(plot1, type=1, facet.var="order", color.var="site")


##
#Archivo Riqueza observada y estamada por Sitio para comparar: "Riqueza observada y estimada x sitio.txt"
riq<- read.table(file.choose(), header = TRUE)
riq

ggplot(riq, aes(y = RiqObsq.0, x = Cond, fill = SITIO)) + 
  stat_summary(fun.y = 'mean', fun.ymin = function(x) 0, geom = 'bar', 
               aes(fill =SITIO), position = 'dodge') +
  stat_summary(fun.ymin = function(x) mean(x) - sd(x), 
               fun.ymax = function(x) mean(x) + sd(x),  position ='dodge', 
               geom = 'errorbar', aes(group = SITIO))

ggplot(riq, aes(y = RiqObsq.1, x = Cond, fill = SITIO)) + 
  stat_summary(fun.y = 'mean', fun.ymin = function(x) 0, geom = 'bar', 
               aes(fill =SITIO), position = 'dodge') +
  stat_summary(fun.ymin = function(x) mean(x) - sd(x), 
               fun.ymax = function(x) mean(x) + sd(x),  position ='dodge', 
               geom = 'errorbar', aes(group = SITIO))

boxplot(RiqObsq.0 ~ Cond, data = riq, lwd = 2, ylab = 'Riqueza observada (q=0)', xlab="Condición")
stripchart(RiqObsq.0 ~ Cond, vertical = TRUE, data = riq, 
           method = "jitter", add = TRUE, pch = 20, col = c("chartreuse4", "orange2", "red"))

boxplot(RiqObsq.1 ~ Cond, data = riq, lwd = 2, ylab = 'Riqueza observada (q=1)', xlab="Condición")
stripchart(RiqObsq.1 ~ Cond, vertical = TRUE, data = riq, 
           method = "jitter", add = TRUE, pch = 20, col = c("chartreuse4", "orange2", "red"))


ggplot(riq, aes(y = RiqObsq.0, x = Cond)) + 
  stat_summary(fun.y = 'mean', fun.ymin = function(x) 0, geom = 'bar')+ 
  stat_summary(fun.ymin = function(x) mean(x) - sd(x), 
               fun.ymax = function(x) mean(x) + sd(x),  position ='dodge', 
               geom = 'errorbar')

ggplot(riq, aes(y = RiqObsq.1, x = Cond)) + 
  stat_summary(fun.y = 'mean', fun.ymin = function(x) 0, geom = 'bar')+ 
  stat_summary(fun.ymin = function(x) mean(x) - sd(x), 
               fun.ymax = function(x) mean(x) + sd(x),  position ='dodge', 
               geom = 'errorbar')

##Pruebo un modelo mixto para Conteos con sitios anidado en Condición
library(lme4)
mod<-glm(RiqObsq.0 ~ Cond, family = poisson, data=riq)
summary(mod)
plot(mod) #ajuste del modelo

#Fixed effects:
#              Estimate Std. Error z value Pr(>|z|)    
#(Intercept)  3.47093    0.07198  48.220   <2e-16 ***
# CondSilvo   -0.05868    0.10332  -0.568     0.57     #hay una tendencia de menor riqueza en silvo, pero no es significativa

#Estimamos sobredispersión:
logLik(mod) #extraigo los grados de libertad del modelo
Discrep.Pear1<-sum(resid(mod,type="pearson")^2)
dp3<-Discrep.Pear1/(12-2) #nº de casos menos los grados de libertad.
dp3 # 0.677669 no hay sobredispersión


#Análisis para riqueza estimada a Q=1
mod1<-lm(RiqObsq.1 ~ Cond, data=riq)
summary(mod1)
plot(mod1) #el ajuste es mas o menos bueno

#Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   16.937      1.348  12.563  1.9e-07 ***
# CondSilvo     -2.167      1.907  -1.137    0.282    #No hay diferencias significativas entre condiciones



