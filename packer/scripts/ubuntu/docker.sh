#!/bin/sh
set -exu

sudo curl -sSL https://get.docker.com/ | sh &> /dev/null
sudo usermod -aG docker ${USER}
