#!/bin/sh

webui_container="open-webui"
webui_image="$(podman images 'open-webui' -q)"
webui_ports="3000:8080"
webui_storage="/app/backend/data"
webui_local_url="OLLAMA_BASE_URL=http://127.0.0.1:11434"
webui_container_repo="ghcr.io/open-webui/open-webui:main"

podman stop "$webui_container" && printf "- Container has been stopped"
podman rm "$webui_container" && printf "- Container has been removed"
podman rmi "$webui_image"

podman run \
--network=host -d -p "$webui_ports" \
-v "$webui_container":"$webui_storage" \
-e "$webui_local_url" \
--replace \
--name "$webui_container" \
"$webui_container_repo" \
