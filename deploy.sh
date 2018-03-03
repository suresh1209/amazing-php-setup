#!/bin/bash

set -x
cd ansible
ansible-playbook -i ../hosts "main.yml"
