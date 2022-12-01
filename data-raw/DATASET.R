## code to prepare `DATASET` dataset goes here
T_obs <- 5 # panel size
n_subj <- 50 # sample size
sig <- diag(rep(1,T_obs))
id <- rep(1:n_subj, each=T_obs)
# year <- rep(1:T_obs, n_subj)
rvec <- c(mvtnorm::rmvnorm(n_subj, sigma = sig))
fvec <- (1 + rep(rnorm(n_subj) , each=T_obs))
pred1 <- rt(n_subj*T_obs, df=2, ncp=1.3)
pred2 <- 1.2*fvec + rnorm(n_subj*T_obs, mean = 0.85, sd=1.5)

sim_panel_data <- data.frame(id= id, pred1, pred2,
                            resp = 0.6*pred1 + pred2 + fvec + rvec,
                            nobs = 50, year = rep(1:5, 50)
)

usethis::use_data(sim_panel_data)


# save(sim_panel_data, file='data/sim_panel_data.Rda')
# write.table(df, file='data/sim_panel_data.csv', sep=",", row.names=FALSE)

# usethis::use_data(DATASET, overwrite = TRUE)
# 
# # usethis::create_package("erfe")
# usethis::use_news_md()
# 
# usethis::use_testthat()
# 
# devtools::test()
# 
# devtools::test_coverage()
# 
# devtools::check()
# 
# devtools::load_all()
# 
# usethis::use_data(sim_panel_data)
# 
# usethis::use_test("erfe")
# 
# devtools::load_all()
# 
# library(covr) # Test Coverage for Packages
# detach("package:erfe", unload = TRUE)
# covr::codecov(token = "CODECOV_TOKEN=6c3191a7-7be5-4614-9797-a0d7cc3d0416")
# 
# 
# usethis::use_github_action_check_standard()
