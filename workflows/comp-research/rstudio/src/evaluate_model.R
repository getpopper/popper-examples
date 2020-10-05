library(tidyverse)
library(tidymodels)

DATA_PATH = "../data"
OUTPUT_PATH = "../output"

source("models.R")

df_train <- read_csv(paste(DATA_PATH, "training_set_features.csv", sep = "/"))
y_train <- read_csv(paste(DATA_PATH, "training_set_labels.csv", sep = "/"))

df_train <- 
    left_join(df_train, y_train, on = "respondent_id", keep = FALSE) %>% 
    select(!"respondent_id")

get_cv_results <- function(df_train, target, ignored) {

    # define model
    lr_model <-
        logistic_reg(penalty = tune(), mixture = 1) %>%
        set_engine("glmnet")

    wf <-
        workflow() %>%
        add_recipe(get_preprocessor(df_train, target, ignored)) %>% 
        add_model(lr_model) 

    # cv parameteds
    folds <- df_train %>% vfold_cv(v = 5)
    lr_grid <- 
        grid_regular(
            penalty(range = c(-2,1), trans = log10_trans()), 
            levels = 10
        )

    # collect cv results
    cv_res <- 
        wf %>%
        tune_grid(
            resamples = folds,
            grid = lr_grid,
            metric = metric_set(roc_auc)
        ) %>%
        collect_metrics()

    # plot_results
    cv_res %>%
    ggplot(aes(penalty, mean)) +
    geom_line(size = 1.2, color = "red", alpha = 0.5) + 
    geom_point(color = "red") + 
    scale_x_log10(labels = scales::label_number()) +
    scale_color_manual(values = c("#CC6666")) +
    ggtitle(expression(paste("AUC for different ", L[1], " penalties")))

    ggsave(
        paste("cv_", target, ".png", sep = ""), 
        path = paste(OUTPUT_PATH, "figures", sep = "/")
    )
}

get_cv_results(df_train, "h1n1_vaccine", "seasonal_vaccine")
get_cv_results(df_train, "seasonal_vaccine", "h1n1_vaccine")