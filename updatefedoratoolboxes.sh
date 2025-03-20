#!bin/bash
#Loops through all podman containers, starting and running dnf update within ones using the fedora image, stopping them afterwards.

for id in $(podman ps -aq); do
    podman start $id
    if [[ $(podman inspect -f '{{.Config.Image}}' $id) == "registry.fedoraproject.org/fedora-toolbox:37" ]]; then
        podman exec $id sudo dnf update -y
	podman stop $id
    fi
done
