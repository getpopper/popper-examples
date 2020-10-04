library(tidyverse)
library(tidymodels)
DATA_PATH = "../../data"

df_train <- read_csv(paste(DATA_PATH, "training_set_features.csv", sep = "/"))
y_train <- read_csv(paste(DATA_PATH, "training_set_labels.csv", sep = "/"))
df_test <- read_csv(paste(DATA_PATH, "test_set_features.csv", sep = "/"))
df_submission <- read_csv(paste(DATA_PATH, "submission_format.csv", sep = "/"))

df_train <- left_join(df_train, y_train, on = "respondent_id", keep = FALSE) %>% 
  select(!"respondent_id")

get_predictions <- function(target, ignored, df_train, df_test) {
    predictions <-
        get_lr_model(df_train, target, ignored) %>%
        fit(data = df_train) %>%
        predict(df_test, type = "prob") %>%# targets are probabilities
        select(".pred_1")
}

preds_seasonal <- 
    get_predictions("seasonal_vaccine", "h1n1_vaccine", df_train, df_test) %>%
    select(".pred1")
preds_h1n1 <- 
    get_predictions("h1n1_vaccine", "seasonal_vaccine", df_train, df_test) %>%
    select(".pred1")

df_submission %>%
  mutate(h1n1_vaccine = preds_h1n1) %>%
  mutate(seasonal_vaccine = preds_seasonal) %>%
  write_csv('../output/submission.csv')


