library(tidyverse)
library(tidymodels)

get_preprocessor <- function(df_train, target, ignored) {
    df_train <- df_train %>% select(!ignored)
    rec <-
        recipe(as.formula(paste(target, "~ .")), data = df_train) %>% 
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
    return(rec)
}

