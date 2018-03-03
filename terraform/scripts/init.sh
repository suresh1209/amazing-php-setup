#!/bin/bash

# ssh lock
echo 'PermitRootLogin without-password' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
reload ssh

# nginx optimizations
sed -i "s/worker_connections .*/worker_connections $(ulimit -n);/" /etc/nginx/nginx.conf
