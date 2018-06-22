#!/bin/bash
set -ex

cd vagrant

vagrant up --provision
vagrant reload
