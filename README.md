# Regression Estimation with ALS Auxiliary Data

## Project Overview

This exercise compares simple random sampling and regression estimation for per-hectare volume using a population of 195 plots with ALS-derived auxiliary information. The workflow uses a sample size of 15, repeats both SRS and regression estimation in 2000 Monte Carlo replications, and evaluates how remote sensing improves estimation accuracy. 

## Objectives

- Estimate mean forest volume using simple random sampling.
- Evaluate uncertainty with finite population correction.
- Apply regression estimation using ALS auxiliary data.
- Compare empirical and estimated standard errors.
- Test how sample size changes when remote sensing support is available. 

## Data

- `vera.txt`
- 195 sample plots
- Response variable: `V` (per-hectare volume)
- Auxiliary variable: `f_havg` (average height of ALS first returns) 

## Methodology

### Simple Random Sampling
A random sample of 15 plots was selected without replacement. The sample mean of volume and its variance were estimated using finite population correction. 

### Resampling SRS
The SRS procedure was repeated 2000 times to compare the empirical standard deviation of sample means with the average estimated standard error. :contentReference[oaicite:13]{index=13}

### Regression Estimation
A linear regression model `V ~ f_havg` was fitted to the sample. The known population mean of `f_havg` was then used to estimate the population mean volume, and residuals were used for variance estimation. 

### Resampling RE
The regression-estimation workflow was repeated 2000 times to evaluate stability and compare the empirical standard deviation of estimates with the average estimated standard error. :contentReference[oaicite:15]{index=15}

### Sample-Size Test
The final step calculated how many plots would be needed to achieve the same accuracy without using the remote-sensing-assisted estimator. 

## Main Outputs

- SRS mean volume and standard error
- Monte Carlo distribution of SRS estimates
- Regression-estimation mean volume and standard error
- Monte Carlo distribution of regression estimates
- Estimated sample size needed for comparable accuracy :contentReference[oaicite:17]{index=17}

## Skills Demonstrated

- Forest sampling theory
- Model-assisted regression estimation
- ALS-based auxiliary-variable use
- Monte Carlo resampling
- Residual-based variance estimation
- Sample-size planning in forest inventory 
 
