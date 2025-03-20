#! bin/bash

for i in $(toolbox list -c | tail -n +2 |awk '{print $1}'); do toolbox run -c $i sudo dnf update -y; done
for i in $(toolbox list -c | tail -n +2 |awk '{print $1}'); do toolbox run -c $i sudo dnf clean all -y; done
