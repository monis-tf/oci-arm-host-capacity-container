# oci-arm-host-capacity-container

Refer to the original repository [hitrov/oci-arm-host-capacity](https://github.com/hitrov/oci-arm-host-capacity) for documentation. Mount your own enviroment file and private key into the container, do not publish them.

The script was taken entirely from the mentioned [repository](https://github.com/hitrov/oci-arm-host-capacity).

Uses php:8.5-cli-alpine3.23 image.

## Example of a [podman systemd unit](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html), run root-less:
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

### This can be paired with a [systemd timer](https://www.freedesktop.org/software/systemd/man/latest/systemd.timer), such as:
    [Unit]
    Description=Run oci script randomly every 5-10 minutes
    
    [Timer]
    OnUnitInactiveSec=5m
    RandomizedDelaySec=5m
    Persistent=true
    
    [Install]
    WantedBy=timers.target
Please note that by default systemd can trigger the timer within a 1 minute window, which can be changed with AccuracySec= option (can be set to 1us for best accuracy). See [docs](https://www.freedesktop.org/software/systemd/man/latest/systemd.timer.html) for details.
