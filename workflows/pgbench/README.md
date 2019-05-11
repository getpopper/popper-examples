# Compare `pgbench` performance

A [Github Actions](https://github.com/features/actions) workflow 
exemplifying how to compare two distinct versions of the 
[PostgreSQL](https://www.postgresql.org) server (comparing 
[`pgbench`](https://www.postgresql.org/docs/current/pgbench.html) 
performance).

To execute this workflow locally on your computer, you can install 
[Popper](https://github.com/systemslab/popper) and 
[Docker](https://docs.docker.com/install/). Once installed, you can 
import the workflow into your project by doing:

```bash
cd myproject/
popper add popperized/popper-examples/workflows/pgbench
```

And run it by executing:

```bash
popper run
```

To modify the versions of postgres being tested, modify the 
`PG_IMAGES` variable specified in the workflow.
