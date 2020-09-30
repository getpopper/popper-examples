library(tidyverse)
library(tidymodels)

get_lr_model <- function(df_train, target, ignored) {
    df_train <- df_train %>% select(!ignored)

    rec <-
        recipe(as.formula(paste(target, "~ .")), data = df_train) %>% 
        step_rm(respondent_id) %>% 
        step_medianimpute(all_numeric()) %>% 
        step_normalize(all_numeric(), -all_outcomes()) %>% 
        step_unknown(all_nominal()) %>% 
        step_dummy(all_nominal()) %>% 
        step_num2factor(
          target, 
          transform = function(x) as.integer(x + 1), 
          levels = c("0", "1"),
          skip=TRUE
        )

    lr_model <- 
        logistic_reg(penalty = 1.0, mixture = 1) %>% 
        set_engine("glm")

    wf <- 
        workflow() %>% 
        add_recipe(rec) %>% 
        add_model(lr_model)  

    return(wf)
}

