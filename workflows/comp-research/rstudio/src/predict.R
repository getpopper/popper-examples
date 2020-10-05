library(tidyverse)
library(tidymodels)

DATA_PATH = "../data"
OUTPUT_PATH = "../output"

source("models.R")

df_train <- read_csv(paste(DATA_PATH, "training_set_features.csv", sep = "/"))
y_train <- read_csv(paste(DATA_PATH, "training_set_labels.csv", sep = "/"))
df_test <- read_csv(paste(DATA_PATH, "test_set_features.csv", sep = "/"))
df_submission <- read_csv(paste(DATA_PATH, "submission_format.csv", sep = "/"))

df_train <- 
    left_join(df_train, y_train, on = "respondent_id", keep = FALSE) %>% 
    select(!"respondent_id")

get_predictions <- function(target, ignored, df_train, df_test) {
    lr_model <- 
        logistic_reg(penalty = 0.01, mixture = 1) %>% 
        set_engine("glmnet")
    
    predictions <-
        workflow() %>%
        add_recipe(get_preprocessor(df_train, target, ignored)) %>%
        add_model(lr_model) %>%
        fit(data = df_train) %>%
        predict(df_test, type = "prob") %>% # targets are probabilities
        pull(".pred_1") # we want the probability *being* vaccinated

    return(predictions)
}

preds_seasonal <- 
    get_predictions("seasonal_vaccine", "h1n1_vaccine", df_train, df_test)

preds_h1n1 <- 
    get_predictions("h1n1_vaccine", "seasonal_vaccine", df_train, df_test)

# save predictions to submission file
df_submission %>%
    mutate(h1n1_vaccine = preds_h1n1) %>%
    mutate(seasonal_vaccine = preds_seasonal) %>%
    write_csv(paste(OUTPUT_PATH, "submission.csv", sep = "/"))


