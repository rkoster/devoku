#!/bin/sh
set -exu

# Disable DNS reverse lookup
echo "UseDNS no" | sudo tee -a /etc/ssh/sshd_config
