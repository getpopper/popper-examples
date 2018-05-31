# Parametrized pipelines

This simple pipeline shows how one might parametrize a pipeline using
environment variables. The pipeline will fail if the N_REPETITIONS
envvar isn't set. So in this case, `popper run envvar-param` will fail,
where `N_REPETITIONS=10 popper run envvar-param` will not.

