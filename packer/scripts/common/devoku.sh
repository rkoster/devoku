#!/bin/sh
set -exu

sudo mkdir -p /opt/devoku
cd /opt/devoku
curl -L https://api.github.com/repos/adaptivdesign/devoku/tarball | sudo tar xz --strip-components=1

tee ~/.bashrc -a > /dev/null <<EOF
PATH=$PATH:/opt/devoku/bin
EOF
