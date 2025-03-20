#!bin/bash
#Loops through all podman containers, starting and running dnf update within the ones using the fedora toolbox image, stopping them afterwards.

image='registry.fedoraproject.org/fedora-toolbox:37'

for id in $(podman ps -aq); do
    podman start $id
    if [[ $(podman inspect -f '{{.Config.Image}}' $id) == "$image" ]]; then
        podman exec $id sudo dnf update -y
	podman stop $id
    fi
done
