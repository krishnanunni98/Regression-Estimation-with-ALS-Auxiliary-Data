###############################################################################################
#
#  Sampling exercise.
#  Data contain 195 sample plots for which several stand attributes and ALS metrics have been computed.
#


#  Prepare the environment and initialize variables.
rm(list = ls()) #tk: clean the environment

po <- read.table("C:/Users/krish/downloads/vera.txt", header=TRUE, sep="," ) #tk: change the path according to your folder location
mc_rep <- 2000  #tk: number of repeats  
N <- nrow(po)   #tk: number of observations (195)
n <- 15         #tk: sample size

# Let's define our own funtion 'samp' which returns a random sample of the
# specified size from our population without replacement.
samp <- function(n){
  po[po$plot_id %in% sample(po$plot_id, n, replace=FALSE),]
}



### Task 1:  Simple Random Sampling (SRS)

# Take a sample of size n (15)
t1.sn <- samp(n)

# Estimated variance
t1.varhy <- ((N-n)/N)*(var(t1.sn$V)/n)

# Print mean and SEE
mean(t1.sn$V)    # estimate of the population mean
sqrt(t1.varhy)   # standard error of the estimate





### Task 2: Resampling SRS.
### By the MC simulation mean and variance estimates may be
### compared to observed values. Below 2000 iterations.

t2.meanhy <- vector()
t2.varhy <- vector()

for (i in 1:mc_rep){
  t2.sn <- samp(n)
  t2.meanhy[i] <- mean(t2.sn$V)
  t2.varhy[i] <- ((N-n)/N)*(var(t2.sn$V)/n)
}

mean(po$V)        # observed population mean
mean(t2.meanhy)   # mean of the estimates of the population mean

sd(t2.meanhy)        # standard deviation of the estimates of the population mean (= observed SE)
mean(sqrt(t2.varhy)) # mean of the standard error of the estimate (= estimated SE)



### Task 3: Regression estimation (RE).

#  Note that in regression estimation variance estimator underestimates
#  variance i.e. it is slightly biased.

# Take a sample of size n
t3.sn <- samp(n)

# First estimate Least Squares coefficients for a sample
m <- lm(t3.sn$V ~ t3.sn$f_havg)
b0 <- coef(m)[1]; names(b0) <- c()
b1 <- coef(m)[2]; names(b1) <- c()

#  Estimate of the population mean. Note that we know what is the
#  mean(po$f_havg), i.e. x-values are known from the whole area
#  (i.e. population) and used as auxiliary data to improve estimation accuracy.
t3.meanhy <- b0+b1*mean(po$f_havg)

# Estimate of the variance
t3.varhy <- ((N-n)/((N*n)*(n-2))) * sum((t3.sn$V-b0-b1*t3.sn$f_havg)^2)

### Print mean and SEE
t3.meanhy            # estimate of the population mean
sqrt(t3.varhy)       # standard error of the estimate

#tk: Compare the values above to the results of SRS.



### Task 4: Resampling RE.
### Comparison of mean and variance estimates to observed values
### by MC simulation. 2000 iterations.
t4.meanhy <- vector()
t4.varhy <- vector()

for (i in 1:mc_rep){
  t4.sn <- samp(n)
  m <- lm(t4.sn$V ~ t4.sn$f_havg)
  b0 <- coef(m)[1]
  b1 <- coef(m)[2]
  t4.meanhy[i] <- b0+b1*mean(po$f_havg)
  t4.varhy[i] <- ((N-n)/((N*n)*(n-2))) * sum((t4.sn$V-b0-b1*t4.sn$f_havg)^2)
}

mean(po$V)        # population mean (again)
mean(t4.meanhy)   # mean of the estimates of the population mean

sd(t4.meanhy)        # standard deviation of the estimates of the population mean (= observed SE)
mean(sqrt(t4.varhy)) # mean of the standard error of the estimate (= estimated SE)



### Task 5: Test the effects of changing sample size.
#tk: Estimate obtained with the assistance of remote sensing and 15 field plots was calculated in task 4. 

d <- 1.96*mean(sqrt(t4.varhy)) #tk: d = the largest acceptable deviation (in m3/ha); 5% -> 1.96*observed standard error
n0 <- ((1.96/d)^2)*var(po$V)   #tk: sample size without finite population correction
nsize <- n0/(1+(n0/N))         #tk: sample size with the finite population correction because sample was picked without replacement
nsize

# End of the R-script