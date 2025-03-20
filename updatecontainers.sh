#! bin/bash

for i in $(podman ps -aq); do podman exec $i sudo dnf update -y; done
for i in $(podman ps -aq); do podman exec $i sudo dnf clean all -y; done
