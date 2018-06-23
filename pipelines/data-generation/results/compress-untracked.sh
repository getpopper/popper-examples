#!/bin/bash

mkdir -p previous

COMMIT_SHORT=$(git rev-parse --short HEAD)

git ls-files \
  --others \
  --exclude-standard \
  --exclude='previous/' \
  -z | cpio -pmd0 previous/${COMMIT_SHORT}

tar cvfz previous/${COMMIT_SHORT}.tgz previous/${COMMIT_SHORT}

rm -r previous/${COMMIT_SHORT}
