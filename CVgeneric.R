library(tidyverse)

# Generic cross validation (CV) function----------
CVgeneric <- function(classifier, train_x, train_y, K, loss_f){
  #INPUT  
  #classifier: pick a classifier, e.g., linear_classifier
  #            but classifier needs to be a function
  #train_x: training dataframe 
  #train_y: train response feature name in CHARACTER
  #K: number of folds you want to use
  #loss_f: loss function you want to use
  #OUTPUT
  # first element is individual MSE across folds
  # second element is the average MSE across folds
  
  # Create K - folds
  CVmse <- numeric(K)
  fold <- createFolds(train_x[[1]], k = K)
  
  
  
  # for loop to go through each fold
  for (i in 1:K) {
    data_loop <- train_x[-fold[[i]], ]      # data for training
    data_loop_test <- train_x[fold[[i]], ]  # fold used for evaluating
    y_true_test <- data_loop_test[[train_y]]# true y values for evaluating
    
    # when we run a model, we do not want response variable to be 
    # one of the predictors
    # If we do not do this, we get an accuracy of 1, which is misleading
    # because it will use y to predict y, <- perfect classification
    data_loop_1 <- data_loop
    data_loop_1[[train_y]] <- NULL
    
    # Run the model
    fit <- classifier(data_loop[[train_y]], data_loop_1)
    
    # predict the response variable with model trained
    
    if (has_error(predict(fit, newdata = data_loop_test)$class, 
                  silent = T) == TRUE){
      # has error part is necessary because for a lda and qda 
      # need to use predict()$class instead of predict() for
      # fitted (predicted) values
      y_hat <- predict(fit, newdata = data_loop_test) %>% 
        round() %>% 
        array()
      
      # calculate the accuracy
      acc <- loss_f(y_true_test, y_hat)
      CVmse[i] <- 1 - acc
    }else{
      y_hat <- predict(fit, newdata = data_loop_test)$class %>% 
        as.double() %>% 
        array()
      
      # calculate the accuracy
      acc <- loss_f(y_true_test, y_hat)
      CVmse[i] <- 1 - acc
    }
    
  }
  # return the average of the MSE
  return(list(CVmse, mean(CVmse)))
}