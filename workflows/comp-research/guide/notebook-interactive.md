# Launching an interactive notebook

## Launching jupyter in interactive mode using docker

In your local shell
```bash
popper sh -f wf.yml jupyter
```
In the shell in the docker container, run
```bash
jupyter notebook --ip 0.0.0.0 --no-browser --allow-root
```

- `--no-browser` tells jupyter to not expect to find a browser in the docker container

Copy and paste the generated link in the browser on your host machine
