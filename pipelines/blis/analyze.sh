#!/bin/bash
set -e -x
docker run -d -v `pwd`:/code/experiment -p 8888:8888 smizy/octave:4.2.0-alpine jupter notebook --NotebookApp.token=""
echo "Open Browser and point it to http://localhost:8888/tree/experiment"
