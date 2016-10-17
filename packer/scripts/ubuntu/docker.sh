#!/bin/sh
set -exu

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker ${USER}
