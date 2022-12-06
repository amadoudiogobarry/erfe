## code to prepare `DATASET` dataset goes here
temp_obs <- 5 # panel size
n_subj <- 50 # sample size
sig <- diag(rep(1, temp_obs))
id <- rep(1:n_subj, each = temp_obs)
rvec <- c(mvtnorm::rmvnorm(n_subj, sigma = sig))
fvec <- (1 + rep(rnorm(n_subj), each = temp_obs))
pred1 <- rt(n_subj * temp_obs, df = 2, ncp = 1.3)
pred2 <- 1.2 * fvec + rnorm(n_subj * temp_obs, mean = 0.85, sd = 1.5)
sim_panel_data <- data.frame(id = id, pred1, pred2,
                             resp = 0.6 * pred1 + pred2 + fvec + rvec,
                             nobs = 50, year = rep(1:5, 50))
usethis::use_data(sim_panel_data)
