library(sets)
library(readxl)

#----Read input data from Excel file----

Input_data <- read_excel("Input data.xlsx")
Data <- Input_data[c('Index of corruption rejection','Index of economic stability','Index of political stability')]
colnames(Data) <- c('IOCR', 'IOES', 'IOPS')
Results <- c()

#----Define the significant points a, b, c, d for the intervals----

# a represents the start of the "common" interval (20)
# b represents the end of the "low" interval (40)
# c represents the start of the "high" interval (60)
# d represents the end of the "common" interval (80)

a <- 20  # Start of the "common" interval
b <- 40  # End of the "low" interval
c <- 60  # Start of the "high" interval
d <- 80  # End of the "common" interval


#----Set up the fuzzy universe and define fuzzy variables and rules----

sets_options("universe", seq(0, 100, 0.1))

variables <-
  set(IOCR = fuzzy_variable(KL = fuzzy_trapezoid(corners = c(-1, 0, a, b)),
                            KM = fuzzy_trapezoid(corners = c(a, b, c, d)),
                            KH = fuzzy_trapezoid(corners = c(c, d, 100, 101))),
      IOES = fuzzy_variable(EL = fuzzy_trapezoid(corners = c(-1, 0, a, b)),
                            EM = fuzzy_trapezoid(corners = c(a, b, c, d)),
                            EH = fuzzy_trapezoid(corners = c(c, d, 100, 101))),
      IOPS = fuzzy_variable(PL = fuzzy_trapezoid(corners = c(-1, 0, a, b)),
                            PM = fuzzy_trapezoid(corners = c(a, b, c, d)),
                            PH = fuzzy_trapezoid(corners = c(c, d, 100, 101))),
      
      IBEQ = fuzzy_variable(QL = fuzzy_trapezoid(corners = c(-1, 0, a, b)),
                            QM = fuzzy_trapezoid(corners = c(a, b, c, d)),
                            QH = fuzzy_trapezoid(corners = c(c, d, 100, 101)))
  )

rules <- set(
  fuzzy_rule(IOCR %is% KL && IOES %is% EL && IOPS %is% PL, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KL && IOES %is% EL && IOPS %is% PM, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KL && IOES %is% EL && IOPS %is% PH, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KL && IOES %is% EM && IOPS %is% PL, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KL && IOES %is% EM && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KL && IOES %is% EM && IOPS %is% PH, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KL && IOES %is% EH && IOPS %is% PL, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KL && IOES %is% EH && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KL && IOES %is% EH && IOPS %is% PH, IBEQ %is% QH),
  
  fuzzy_rule(IOCR %is% KM && IOES %is% EL && IOPS %is% PL, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KM && IOES %is% EL && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EL && IOPS %is% PH, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EM && IOPS %is% PL, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EM && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EM && IOPS %is% PH, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EH && IOPS %is% PL, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EH && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KM && IOES %is% EH && IOPS %is% PH, IBEQ %is% QH),
  
  fuzzy_rule(IOCR %is% KH && IOES %is% EL && IOPS %is% PL, IBEQ %is% QL),
  fuzzy_rule(IOCR %is% KH && IOES %is% EL && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KH && IOES %is% EL && IOPS %is% PH, IBEQ %is% QH),
  fuzzy_rule(IOCR %is% KH && IOES %is% EM && IOPS %is% PL, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KH && IOES %is% EM && IOPS %is% PM, IBEQ %is% QM),
  fuzzy_rule(IOCR %is% KH && IOES %is% EM && IOPS %is% PH, IBEQ %is% QH),
  fuzzy_rule(IOCR %is% KH && IOES %is% EH && IOPS %is% PL, IBEQ %is% QH),
  fuzzy_rule(IOCR %is% KH && IOES %is% EH && IOPS %is% PM, IBEQ %is% QH),
  fuzzy_rule(IOCR %is% KH && IOES %is% EH && IOPS %is% PH, IBEQ %is% QH)
)

model <- fuzzy_system(variables, rules)

#----Fuzzy inference for each row of the input data----

print(model)
plot(model)
summary(model)

for (i in 1:nrow(Data)) {
  fi <- fuzzy_inference(model, list(IOCR = Data$IOCR[i], IOES = Data$IOES[i], IOPS = Data$IOPS[i]))
  plot(fi)
  Results[i] <- gset_defuzzify(fi, "centroid")
  sets_options("universe", NULL)
}
plot(fi)
Results
write.csv(Results, "Results.csv")
