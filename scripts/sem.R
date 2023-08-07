library(semPlot)
library(semptools)


# innopoli <- read.csv(file.choose())
innopoli <- read.csv(file.choose())
names(innopoli)
head(innopoli)

library(lavaan)

model <- '
    level: 1
        # direct effect
              covid ~ c*healthcare
                 
        # mediator
              innovation ~ a*healthcare
              covid ~ b*innovation
              
        # indirect effect (a*b)
              ab := a*b
        # total effect
              total := c + (a*b)
    
    level: 2
        # direct effect
              covid ~ c*healthcare
                 
        # mediator
              policy ~ a*healthcare
              covid ~ b*policy
              
        # indirect effect (a*b)
              ab := a*b
        # total effect
              total := c + (a*b)
    
    level: 3
        # direct effect
              innovation ~ c*policy
                 
        # mediator
              healthcare ~ a*policy
              innovation ~ b*healthcare
              
        # indirect effect (a*b)
              ab := a*b
        # total effect
              total := c + (a*b)
    
    level: 4
        # direct effect
              innovation ~ c*policy
                 
        # mediator
              covid ~ a*policy
              innovation ~ b*covid
              
        # indirect effect (a*b)
              ab := a*b
        # total effect
              total := c + (a*b)

'

model <- '
        # direct effect
              innovation ~ c*policy
                 
        # mediator
              covid ~ a*policy
              innovation ~ b*covid
              
        # indirect effect (a*b)
              ab := a*b
        # total effect
              total := c + (a*b)
'

fit <- sem(model, innopoli)
summary(fit, fit.measures = TRUE)
write.csv(parameterEstimates(fit), 'covid_med_model.csv')
write.csv(fitmeasures(fit), 'fit_measures_covid_med_model.csv')


layout(matrix(c(1,2), 1, 2, byrow = TRUE))
semPaths(fit); semPaths(fit, whatLabels = "est",
                        sizeMan = 10,
                        edge.label.cex = 1.15,
                        style = "ram",
                        nCharNodes = 0, nCharEdges = 0) 

p_pa <- semPaths(fit, whatLabels = "est",
                    sizeMan = 10,
                    edge.label.cex = 1.15,
                    style = "ram",
                    nCharNodes = 0, nCharEdges = 0) 

layout(matrix(c(1,2), 1, 2, byrow = TRUE))
semPaths(fit)
p_pa2 <- mark_sig(p_pa, fit)
plot(p_pa2)