# oci-arm-host-capacity-container

Refer to the original repository [hitrov/oci-arm-host-capacity](https://github.com/hitrov/oci-arm-host-capacity) for documentation. Mount your own enviroment file into the container.

The script was taken entirely from the mentioned [repository](https://github.com/hitrov/oci-arm-host-capacity).

Uses php:8.5-cli-alpine3.23 image.

## Example of a podman systemd unit, run root-less:
[Container]

ContainerName=php-alpine

Image=ghcr.io/monis-tf/oci-arm-host-capacity-container:latest

Volume=%h/.config/containers/storage/php-alpine/oci-arm-host-capacity/.env:/app/.env:ro

Volume=%h/.config/containers/storage/php-alpine/oci-arm-host-capacity/EDITED.pem:/app/.oci/EDITED.pem:ro

NoNewPrivileges=yes

DropCapability=ALL

User=1000

Group=1000

LogDriver=journald

[Service]

Type=oneshot
