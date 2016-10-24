#!/bin/sh
set -exu

sudo tee /etc/environment -a > /dev/null <<EOF
PATH=$PATH:/opt/devoku/bin
EOF
