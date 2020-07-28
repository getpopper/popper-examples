from sklearn import impute, preprocessing, compose, pipeline, linear_model, multioutput
from typing import List

def _get_preprocessor(
    num_features: List[str] , cat_features: List: str
) -> compose.ColumnTransformer:
    """
    Returns preprocessing pipeline adapted to specified numerical
    and categorical features
    """

    num_transformer = pipeline.Pipeline([
        ("scale", preprocessing.StandardScaler()),
        ("impute", impute.KNNImputer(n_neighbors = 10)),
    ])

    cat_transformer = pipeline.Pipeline([
        ("impute", impute.SimpleImputer(strategy = "constant", fill_value = "missing")),
        ("encode", preprocessing.OneHotEncoder(drop = "first")),
    ] )

    preprocessor = compose.ColumnTransformer(
        [("num", num_transformer, num_features), 
        ("cat", cat_transformer, cat_features)
    ])
    return preprocessor

def get_lr_model(
    num_features: List[str], cat_features: List[str], C: float = 1.0
) -> pipeline.Pipeline:
    """
    Returns full pipeline for a logistic regression model with 
    specified numerical and categorical features.
    """

    model = pipeline.Pipeline([
        ("pre", _get_preprocessor(num_features, cat_features)),
        ("model", multioutput.MultiOutputClassifier(
                    linear_model.LogisticRegression(penalty="l1", C = C, solver = "saga")
        )),
    ])
    return model
