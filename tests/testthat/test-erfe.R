test_that("Output are not missing and standard errore is positif", {
    # expect_equal(2 * 2, 4)
    outlist <- erfe(predictors=cbind(sim_panel_data$pred1, sim_panel_data$pred2),
                response=sim_panel_data$resp, 
                asymp=c(0.25,0.5,0.75), 
                id=sim_panel_data$id)
     
    out <- outlist[[3]] 
      
    # expect_length(out, length(sim_panel_data$pred1))
    expect_equal(out$asymPoint, 0.75)
    expect_equal(sum(is.na(out$coefEst)), 0)
    expect_equal(sum(is.na(out$standardError)), 0)
    
    expect_true(all(out$standardError>0))
    
})
  