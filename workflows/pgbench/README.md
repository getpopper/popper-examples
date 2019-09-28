# Compare `pgbench` performance

A [Github Actions](https://github.com/features/actions) workflow 
exemplifying how to compare two distinct versions of the 
[PostgreSQL](https://www.postgresql.org) server (comparing 
[`pgbench`](https://www.postgresql.org/docs/current/pgbench.html) 
performance).

To execute this workflow locally on your computer, you need to install 
[Popper](https://github.com/systemslab/popper) and 
[Docker](https://docs.docker.com/install/). Once installed, you run 
the example by doing:

```bash
git clone https://github.com/popperized/popper-examples
cd popper-examples/workflows/workflows/pgbench
popper run
```

To modify the versions of Postgres being tested, modify the 
`PG_IMAGES` variable specified in the workflow.
